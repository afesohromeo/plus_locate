import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plus_locate/plus_locate.dart';

/// What the user confirmed in [showLabelSheet]. An empty [label] means
/// "no label".
typedef LabelSheetResult = ({String label});

/// Asks for an optional label for [plusCode]. Returns null when cancelled.
Future<LabelSheetResult?> showLabelSheet(
  BuildContext context, {
  required String title,
  required String plusCode,
  String? initialLabel,
}) {
  return showModalBottomSheet<LabelSheetResult>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: customColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => LabelSheet(
      title: title,
      plusCode: plusCode,
      initialLabel: initialLabel,
    ),
  );
}

/// Saves [code] after asking for an optional label, pre-filled with the
/// label it already has if this Plus Code was saved before, otherwise with
/// [suggestedLabel] (e.g. the name of a place picked in Search).
Future<void> saveLocationWithLabel(
  BuildContext context,
  SavedCode code, {
  String? suggestedLabel,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final historyBloc = context.read<HistoryBloc>();
  final existingLabel = historyBloc.state.savedCodes
      .where((saved) => saved.globalCode == code.globalCode)
      .firstOrNull
      ?.label;

  final result = await showLabelSheet(
    context,
    title: l10n.saveLocationTitle,
    plusCode: code.globalCode ?? '',
    initialLabel: existingLabel ?? suggestedLabel,
  );
  if (result == null) return;

  historyBloc.add(
    HistoryEvent.saveCode(code: code.copyWith(label: result.label)),
  );
}

class LabelSheet extends StatefulWidget {
  const LabelSheet({
    super.key,
    required this.title,
    required this.plusCode,
    this.initialLabel,
  });

  final String title;
  final String plusCode;
  final String? initialLabel;

  @override
  State<LabelSheet> createState() => _LabelSheetState();
}

class _LabelSheetState extends State<LabelSheet> {
  static const _maxLabelLength = 40;

  /// Pre-filled text starts selected, so typing replaces it in one go.
  late final TextEditingController _controller = () {
    final initial = widget.initialLabel ?? '';
    final text = initial.length > _maxLabelLength
        ? initial.substring(0, _maxLabelLength).trimRight()
        : initial;
    return TextEditingController.fromValue(
      TextEditingValue(
        text: text,
        selection: TextSelection(baseOffset: 0, extentOffset: text.length),
      ),
    );
  }();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() => Navigator.of(context)
      .pop<LabelSheetResult>((label: _controller.text.trim()));

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: context.textTheme.displayLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: customColors.black1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.plusCode,
              style: context.textTheme.displayLarge?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: customColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            InputField(
              controller: _controller,
              focusNode: _focusNode,
              validator: (_) => null,
              labelText: l10n.labelFieldHint,
              labelColor: customColors.black1.withValues(alpha: .7),
              bgColor: customColors.surface,
              borderRadius: BorderRadius.circular(10),
              inputFormatters: [
                LengthLimitingTextInputFormatter(_maxLabelLength),
              ],
              onEditingComplete: _submit,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      l10n.cancel,
                      style: context.textTheme.displayLarge?.copyWith(
                        fontSize: 14,
                        color: customColors.black1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    onPressed: _submit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        l10n.actionSave,
                        style: context.textTheme.displayLarge?.copyWith(
                          fontSize: 14,
                          color: customColors.surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
