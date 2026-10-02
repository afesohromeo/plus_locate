import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plus_locate/src/domain/models/saved_code.dart';

/// Repository for locally stored Plus Codes using Hive.
///
/// Per RULE-012: always log + rethrow, never swallow exceptions.
class SavedCodesRepository {
  static const String _boxName = 'saved_codes';

  /// Opens or returns the Hive box for saved codes.
  Future<Box<SavedCode>> _getBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<SavedCode>(_boxName);
    }
    return await Hive.openBox<SavedCode>(_boxName);
  }

  /// Fetch all saved codes, ordered by most recent first.
  Future<List<SavedCode>> fetchAllSavedCodes() async {
    try {
      final box = await _getBox();
      final codes = box.values.toList();
      // Sort by savedAt descending (most recent first)
      codes.sort((a, b) {
        final aDate = a.savedAt ?? DateTime(2000);
        final bDate = b.savedAt ?? DateTime(2000);
        return bDate.compareTo(aDate);
      });
      return codes;
    } catch (e) {
      log('Error fetching saved codes: $e');
      rethrow;
    }
  }

  /// Save a Plus Code to local storage.
  /// If a code with the same [SavedCode.globalCode] already exists, it is
  /// updated in place (same Hive key) and its [SavedCode.savedAt] is
  /// refreshed so it rises to the top of the history list. A null label keeps
  /// the existing entry's label; a blank one removes it.
  Future<SavedCode?> saveCode(SavedCode code) async {
    try {
      final box = await _getBox();

      final existing = box.values.cast<SavedCode?>().firstWhere(
            (c) => c?.globalCode == code.globalCode,
            orElse: () => null,
          );

      final id = existing?.id ??
          code.id ??
          DateTime.now().millisecondsSinceEpoch.toString();
      final codeToSave = code.copyWith(
        id: id,
        label: code.label == null ? existing?.label : _cleanLabel(code.label),
        savedAt: DateTime.now(),
      );
      await box.put(id, codeToSave);
      return codeToSave;
    } catch (e) {
      log('Error saving code: $e');
      rethrow;
    }
  }

  /// Update an existing saved code.
  Future<SavedCode?> updateCode(SavedCode code) async {
    try {
      final box = await _getBox();
      if (code.id == null) return null;
      await box.put(code.id!, code);
      return code;
    } catch (e) {
      log('Error updating saved code: $e');
      rethrow;
    }
  }

  /// Sets the label of the saved code [id]; a blank [label] removes it.
  /// Returns the updated code, or null if [id] isn't saved.
  Future<SavedCode?> updateLabel({required String id, String? label}) async {
    try {
      final box = await _getBox();
      final existing = box.get(id);
      if (existing == null) return null;

      final updated = existing.copyWith(label: _cleanLabel(label));
      await box.put(id, updated);
      return updated;
    } catch (e) {
      log('Error updating label: $e');
      rethrow;
    }
  }

  static String? _cleanLabel(String? label) {
    final trimmed = label?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  /// Delete a saved code by its ID.
  Future<bool> deleteCode(String id) async {
    try {
      final box = await _getBox();
      await box.delete(id);
      return true;
    } catch (e) {
      log('Error deleting saved code: $e');
      rethrow;
    }
  }

  /// Delete multiple saved codes by their IDs.
  Future<bool> deleteCodes(List<String> ids) async {
    try {
      final box = await _getBox();
      await box.deleteAll(ids);
      return true;
    } catch (e) {
      log('Error deleting saved codes: $e');
      rethrow;
    }
  }

  /// Search saved codes by label or global code.
  Future<List<SavedCode>> searchCodes(String query) async {
    try {
      final allCodes = await fetchAllSavedCodes();
      final lowerQuery = query.toLowerCase();
      return allCodes.where((code) {
        final label = code.label?.toLowerCase() ?? '';
        final globalCode = code.globalCode?.toLowerCase() ?? '';
        final locality = code.locality?.toLowerCase() ?? '';
        return label.contains(lowerQuery) ||
            globalCode.contains(lowerQuery) ||
            locality.contains(lowerQuery);
      }).toList();
    } catch (e) {
      log('Error searching saved codes: $e');
      rethrow;
    }
  }

  static const _exportFormat = 'pluslocate.saved_locations';
  static const _exportVersion = 1;

  /// All saved codes as a versioned JSON document.
  Future<String> exportJson() async {
    try {
      final codes = await fetchAllSavedCodes();
      return const JsonEncoder.withIndent('  ').convert({
        'format': _exportFormat,
        'version': _exportVersion,
        'exported_at': DateTime.now().toIso8601String(),
        'locations': codes.map(SavedCode.toJson).toList(),
      });
    } catch (e) {
      log('Error exporting saved codes: $e');
      rethrow;
    }
  }

  /// Writes [exportJson] to a temporary file and returns its path.
  Future<String> exportToFile() async {
    try {
      final now = DateTime.now();
      final date = '${now.year}-${now.month.toString().padLeft(2, '0')}'
          '-${now.day.toString().padLeft(2, '0')}';
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/pluslocate-saved-$date.json');
      await file.writeAsString(await exportJson());
      return file.path;
    } catch (e) {
      log('Error writing export file: $e');
      rethrow;
    }
  }

  /// Adds the locations from an [exportJson] document. Plus Codes that are
  /// already saved are skipped, so importing the same file twice is safe.
  ///
  /// Throws [FormatException] when [content] isn't a PlusLocate export.
  Future<({int added, int skipped})> importJson(String content) async {
    try {
      final decoded = jsonDecode(content);
      if (decoded is! Map<String, dynamic> ||
          decoded['format'] != _exportFormat ||
          decoded['locations'] is! List) {
        throw const FormatException('Not a PlusLocate export');
      }

      final box = await _getBox();
      final savedCodes = box.values.map((c) => c.globalCode).toSet();
      var added = 0;
      var skipped = 0;

      for (final item in decoded['locations'] as List) {
        if (item is! Map) {
          skipped++;
          continue;
        }
        final code = SavedCode.fromJson(item.cast<String, dynamic>());
        if (code.globalCode == null || savedCodes.contains(code.globalCode)) {
          skipped++;
          continue;
        }

        final id = code.id != null && !box.containsKey(code.id)
            ? code.id!
            : '${DateTime.now().microsecondsSinceEpoch}$added';
        await box.put(
          id,
          code.copyWith(id: id, savedAt: code.savedAt ?? DateTime.now()),
        );
        savedCodes.add(code.globalCode);
        added++;
      }

      return (added: added, skipped: skipped);
    } catch (e) {
      log('Error importing saved codes: $e');
      rethrow;
    }
  }
}
