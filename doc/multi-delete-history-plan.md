# Multi-select / Multi-delete for HistoryPage

## Goal
Allow the user to select multiple saved location cards on the History page and delete them all at once.

## UX
- Long-press a card to enter selection mode: the card shows a checkbox/highlight and becomes selected.
- While in selection mode, tapping any card toggles its selection (instead of navigating to the map).
- AppBar transforms while in selection mode:
  - Leading becomes a close (X) icon to exit selection mode (clears selection).
  - Title shows "{N} selected".
  - Trailing actions: "select all" and "delete" (delete shows a confirmation dialog with a pluralized message, then deletes all selected items).

## Changes

### 1. `lib/src/domain/repository/saved_codes_repository.dart`
- Add `Future<bool> deleteCodes(List<String> ids)` — loops `box.delete(id)` for each id.

### 2. `lib/src/features/history/bloc/history_state.dart`
- Add `@Default(false) bool isSelectionMode`
- Add `@Default(<String>{}) Set<String> selectedIds`

### 3. `lib/src/features/history/bloc/history_event.dart`
- `enterSelectionMode({required String id})`
- `toggleItemSelection({required String id})`
- `selectAllCodes()`
- `exitSelectionMode()`
- `deleteSelectedCodes()`

### 4. `lib/src/features/history/bloc/history_bloc.dart`
- `_onEnterSelectionMode`: sets `isSelectionMode: true`, `selectedIds: {id}`
- `_onToggleItemSelection`: adds/removes id from `selectedIds`; if it becomes empty, exits selection mode
- `_onSelectAllCodes`: sets `selectedIds` to all current `savedCodes` ids
- `_onExitSelectionMode`: resets `isSelectionMode: false`, `selectedIds: {}`
- `_onDeleteSelectedCodes`: sets `flowStep: deletingItem`, `historyActionStatus: loading`; calls `repository.deleteCodes(selectedIds.toList())`; on success emits `historyActionStatus: success`, exits selection mode, re-fetches; on failure emits `historyActionStatus: failure`

### 5. `lib/src/features/history/components/saved_location_card.dart`
- New params: `bool isSelectionMode`, `bool isSelected`, `VoidCallback? onLongPress`, `VoidCallback? onSelectToggle`
- When `isSelectionMode` is true:
  - `onTap` calls `onSelectToggle` instead of the normal navigation callback
  - Card shows a checkbox/circle indicator (checked/unchecked) and a highlighted border/background when selected
- `onLongPress` wired to enter selection mode

### 6. `lib/src/features/history/views/history_page.dart`
- `HistoryPage`: AppBar built conditionally based on `state.isSelectionMode`:
  - Selection mode: leading = close icon (`exitSelectionMode`), title = "{N} selected", actions = select-all icon button + delete icon button
  - Normal mode: existing leading/title
- `_HistoryBody`: wire `onLongPress` → `enterSelectionMode(id: code.id!)`, pass `isSelectionMode`/`isSelected` to `SavedLocationCard`, `onSelectToggle` → `toggleItemSelection(id: code.id!)`
- Delete action shows confirm dialog (pluralized message using `selectedIds.length`), then dispatches `deleteSelectedCodes()`
- Extend the existing `historyActionStatus`/`deletingItem` listener's success message to handle both single and multi delete (pluralized)

### 7. l10n additions (`app_en.arb` + `app_fr.arb`)
- `selectedCount`: "{count} selected" / "{count} sélectionné(s)"
- `selectAll`: "Select all" / "Tout sélectionner"
- `confirmDeleteMultipleTitle`: "Delete saved locations" / "Supprimer les emplacements enregistrés"
- `confirmDeleteMultipleMessage`: "Are you sure you want to delete {count} saved locations?" / "Êtes-vous sûr de vouloir supprimer {count} emplacements enregistrés ?"
- `msgCodesDeleted`: "{count} locations deleted" / "{count} emplacements supprimés"

## Implementation order
1. Repository: `deleteCodes`
2. Bloc: state + event + handlers
3. SavedLocationCard: selection UI
4. HistoryPage/_HistoryBody: AppBar + wiring
5. l10n strings (en + fr)
6. `flutter analyze` + `flutter pub run build_runner build` (freezed regen) verification
