# UI Patterns

## List Page Pattern

**Location:** `lib/src/features/{feature}/views/{feature}_page.dart`

```dart
class MyFeatureListPage extends StatefulWidget {
  const MyFeatureListPage({super.key});

  @override
  State<MyFeatureListPage> createState() => _MyFeatureListPageState();
}

class _MyFeatureListPageState extends State<MyFeatureListPage> {
  MyFeatureDataSource? _dataSource;
  Timer? _debounce;
  Key _tableKey = UniqueKey();
  String? _searchTerm;
  int _rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _initDataSource();
  }

  void _initDataSource() {
    _dataSource?.dispose();
    _dataSource = MyFeatureDataSource(
      bloc: context.read<MyFeatureBloc>(),
      context: context,
      searchTerm: _searchTerm,
    );
  }

  void _onRefresh() {
    setState(() {
      _tableKey = UniqueKey();
      _initDataSource();
    });
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<MyFeatureBloc>().add(const MyFeatureEvent.init());
      setState(() {
        _searchTerm = value.isEmpty ? null : value;
        _tableKey = UniqueKey();
        _initDataSource();
      });
    });
  }

  void _showCreateDialog() {
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    showDialog(
      context: rootContext,
      builder: (_) => BlocProvider.value(
        value: context.read<MyFeatureBloc>(),
        child: CreateUpdateMyFeatureDialog(parentContext: rootContext),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<MyFeatureBloc, MyFeatureState>(
      listenWhen: (prev, curr) =>
          prev.refreshController != curr.refreshController,
      listener: (context, state) {
        if (state.refreshController) _onRefresh();
      },
      buildWhen: (prev, curr) =>
          prev.myFeatureStatus != curr.myFeatureStatus ||
          prev.myFeatures.length != curr.myFeatures.length,
      builder: (context, state) {
        final isLoading = state.myFeatureStatus == GenericStatus.loading ||
            state.myFeatureStatus == GenericStatus.filtering;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: SearchInputField(
                      onChanged: _onSearchChanged,
                      labelText: l10n.search,
                    ),
                  ),
                  PrimaryButton(
                    onPressed: _showCreateDialog,
                    child: Text(l10n.addNew),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const LoadingWidget()
                  : AsyncPaginatedDataTable2(
                      key: _tableKey,
                      source: _dataSource!,
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (value) {
                        if (value != null) {
                          setState(() => _rowsPerPage = value);
                        }
                      },
                      columns: [
                        DataColumn2(label: Text(l10n.name)),
                        DataColumn2(label: Text(l10n.code)),
                        DataColumn2(label: Text(l10n.actions), fixedWidth: 120),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _dataSource?.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
```

---

## DataSource Pattern

**Location:** `lib/src/features/{feature}/data_sources/{feature}_data_source.dart`

```dart
class MyFeatureDataSource extends AsyncDataTableSource {
  final MyFeatureBloc _bloc;
  final BuildContext context;
  final String? _searchTerm;

  StreamSubscription<MyFeatureState>? _subscription;
  String? _errorMessage;

  MyFeatureDataSource({
    required MyFeatureBloc bloc,
    required this.context,
    String? searchTerm,
  })  : _bloc = bloc,
        _searchTerm = searchTerm;

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    final completer = Completer<AsyncRowsResponse>();
    final pageKey = startIndex ~/ count;

    _subscription?.cancel();
    _subscription = _bloc.stream.listen((state) {
      if (state.myFeatureStatus == GenericStatus.success) {
        final rows = state.paginatedMyFeatures
            .map((item) => MyFeatureTile(data: item)
                .buildDataRow(context, onDelete: () => _onDelete(item)))
            .toList();
        if (!completer.isCompleted) {
          completer.complete(AsyncRowsResponse(state.totalCount, rows));
        }
        _subscription?.cancel();
      } else if (state.myFeatureStatus == GenericStatus.failure) {
        _errorMessage = state.myFeatureListErrorMessage ??
            LocalizationService.localization.operationError;
        if (!completer.isCompleted) {
          completer.completeError(_errorMessage!);
        }
        _subscription?.cancel();
      }
    });

    _bloc.add(MyFeatureEvent.fetchMyFeatures(
      pageKey: pageKey,
      searchTerm: _searchTerm,
      size: count,
    ));

    return completer.future;
  }

  void _onDelete(MyFeature item) {
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    showDialog(
      context: rootContext,
      builder: (_) => BlocProvider.value(
        value: _bloc,
        child: DeleteMyFeatureDialog(parentContext: rootContext, item: item),
      ),
    );
  }

  String? get errorMessage => _errorMessage;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
```

---

## Dialog Pattern

```dart
class CreateUpdateMyFeatureDialog extends StatefulWidget {
  const CreateUpdateMyFeatureDialog({
    super.key,
    required this.parentContext,
    this.item,       // null = create mode, non-null = update mode
  });

  final BuildContext parentContext;
  final MyFeature? item;

  @override
  State<CreateUpdateMyFeatureDialog> createState() =>
      _CreateUpdateMyFeatureDialogState();
}

class _CreateUpdateMyFeatureDialogState
    extends State<CreateUpdateMyFeatureDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _codeController;

  bool get _isUpdateMode => widget.item != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _codeController = TextEditingController(text: widget.item?.code ?? '');
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final newItem = MyFeature(
      id: widget.item?.id,
      name: _nameController.text.trim(),
      code: _codeController.text.trim(),
    );

    final bloc = context.read<MyFeatureBloc>();
    if (_isUpdateMode) {
      bloc.add(MyFeatureEvent.updateMyFeature(newItem));
    } else {
      bloc.add(MyFeatureEvent.createMyFeature(newItem));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(widget.parentContext)!;

    return BlocConsumer<MyFeatureBloc, MyFeatureState>(
      listener: (context, state) async {
        final bloc = context.read<MyFeatureBloc>();

        if (state.myFeatureActionStatus == GenericStatus.success &&
            (state.flowStep == GenericFlowStep.creatingItem ||
                state.flowStep == GenericFlowStep.updatingItem)) {
          await DialogUtils.handleSuccess(
            context,
            _isUpdateMode ? l10n.updateSuccess : l10n.createSuccess,
            postActions: [
              () => bloc.add(const MyFeatureEvent.resetFlowStep()),
            ],
            shouldPopDialog: true,
          );
        }

        if (state.myFeatureActionStatus == GenericStatus.failure) {
          await DialogUtils.handleFailure(
            context,
            state.myFeatureActionErrorMessage ?? l10n.operationError,
            postActions: [
              () => bloc.add(const MyFeatureEvent.resetFlowStep()),
            ],
            shouldPopDialog: false,   // Keep dialog open on failure
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.flowStep == GenericFlowStep.creatingItem ||
            state.flowStep == GenericFlowStep.updatingItem;

        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: AlertDialog(
            backgroundColor: customColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(_isUpdateMode ? l10n.edit : l10n.addNew),
            ),
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(thickness: 2, height: 2),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField(
                          controller: _nameController,
                          labelText: l10n.name,
                          validator: (v) =>
                              v == null || v.isEmpty ? l10n.requiredField : null,
                        ),
                        const Gap(12),
                        InputField(
                          controller: _codeController,
                          labelText: l10n.code,
                          validator: (v) =>
                              v == null || v.isEmpty ? l10n.requiredField : null,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 1.5, height: 1.5),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.cancel),
              ),
              PrimaryButton(
                onPressed: isLoading ? null : _onSubmit,
                child: Text(_isUpdateMode ? l10n.update : l10n.save),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}
```

---

## Delete Dialog Pattern

```dart
class DeleteMyFeatureDialog extends StatelessWidget {
  const DeleteMyFeatureDialog({
    super.key,
    required this.parentContext,
    required this.item,
  });

  final BuildContext parentContext;
  final MyFeature item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(parentContext)!;

    return BlocConsumer<MyFeatureBloc, MyFeatureState>(
      listener: (context, state) async {
        final bloc = context.read<MyFeatureBloc>();
        if (state.flowStep == GenericFlowStep.deletingItem &&
            state.myFeatureActionStatus == GenericStatus.success) {
          await DialogUtils.handleSuccess(
            context,
            l10n.deleteSuccess,
            postActions: [
              () => bloc.add(const MyFeatureEvent.resetFlowStep()),
              () => bloc.add(const MyFeatureEvent.refreshMyFeatures()),
            ],
            shouldPopDialog: true,
          );
        }
        if (state.myFeatureActionStatus == GenericStatus.failure) {
          await DialogUtils.handleFailure(
            context,
            state.myFeatureActionErrorMessage ?? l10n.operationError,
            postActions: [() => bloc.add(const MyFeatureEvent.resetFlowStep())],
            shouldPopDialog: true,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state.flowStep == GenericFlowStep.deletingItem,
          child: AlertDialog(
            backgroundColor: customColors.surface,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            title: Text(l10n.deleteConfirmTitle),
            content: Text(l10n.deleteConfirmMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.no),
              ),
              TextButton(
                onPressed: () => context
                    .read<MyFeatureBloc>()
                    .add(MyFeatureEvent.deleteMyFeature(item)),
                child: Text(l10n.yes,
                    style: TextStyle(color: customColors.error)),
              ),
            ],
          ),
        );
      },
    );
  }
}
```

---

## Key UI Rules

### Context Safety
```dart
// ALWAYS capture root context before showDialog
final rootContext = Navigator.of(context, rootNavigator: true).context;
showDialog(context: rootContext, builder: (_) => ...);

// ALWAYS check mounted after async gaps
if (context.mounted) { ... }
```

### BlocConsumer Configuration
- `listenWhen`: compare only the fields the listener needs (minimize rebuilds)
- `buildWhen`: compare only fields used in the builder
- Use `prev.refreshController != curr.refreshController` to detect refresh triggers

### Dialog Styling
```dart
AlertDialog(
  backgroundColor: customColors.surface,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  contentPadding: EdgeInsets.zero,  // Always zero — use manual inner padding
  content: Column(children: [
    const Divider(thickness: 2, height: 2),  // Top divider: thickness 2
    Padding(padding: EdgeInsets.all(16), child: ...),
    const Divider(thickness: 1.5, height: 1.5),  // Bottom divider: thickness 1.5
  ]),
)
```

### DropdownButtonFormField
```dart
DropdownButtonFormField<MyModel>(
  isExpanded: true,   // ALWAYS — prevents overflow
  ...
)
```

### Search Debounce
```dart
Timer? _debounce;

void _onSearchChanged(String value) {
  if (_debounce?.isActive ?? false) _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    // search action
  });
}
```

### Table Refresh via UniqueKey
```dart
Key _tableKey = UniqueKey();

// To force full table rebuild:
setState(() {
  _tableKey = UniqueKey();
  _initDataSource();
});
```
