import 'dart:developer';

import 'package:hive/hive.dart';
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

  /// Save a new Plus Code to local storage.
  Future<SavedCode?> saveCode(SavedCode code) async {
    try {
      final box = await _getBox();
      final id = code.id ?? DateTime.now().millisecondsSinceEpoch.toString();
      final codeToSave = code.copyWith(
        id: id,
        savedAt: code.savedAt ?? DateTime.now(),
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
}
