import 'package:hive/hive.dart';

/// Tracks how many Places Autocomplete searches this device has used in the
/// current calendar month, and decides when to fall back to the free
/// search-on-submit (device geocoding) flow.
///
/// This is a client-side cost-smoothing mechanism only. The real safety net
/// against runaway Places API spend is a daily quota + budget alert
/// configured in the Google Cloud Console.
class SearchQuotaRepository {
  static const String _boxName = 'search_quota';
  static const String _countKey = 'count';
  static const String _monthKey = 'month';

  /// Maximum number of Places Autocomplete searches allowed per device,
  /// per calendar month, before falling back to search-on-submit.
  static const int maxMonthlyAutocompleteSearches = 15;

  Future<Box> _getBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box(_boxName);
    }
    return Hive.openBox(_boxName);
  }

  String get _currentMonthKey {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }

  /// Returns the usage count for the current month, resetting it to 0 if
  /// the stored count belongs to a previous month.
  Future<int> _currentMonthCount(Box box) async {
    final storedMonth = box.get(_monthKey) as String?;
    if (storedMonth != _currentMonthKey) {
      await box.put(_monthKey, _currentMonthKey);
      await box.put(_countKey, 0);
      return 0;
    }
    return box.get(_countKey, defaultValue: 0) as int;
  }

  /// Whether the device can still use Places Autocomplete this month.
  Future<bool> canUseAutocomplete() async {
    final box = await _getBox();
    final count = await _currentMonthCount(box);
    return count < maxMonthlyAutocompleteSearches;
  }

  /// Records one Places Autocomplete usage for the current month.
  Future<void> recordAutocompleteUsage() async {
    final box = await _getBox();
    final count = await _currentMonthCount(box);
    await box.put(_countKey, count + 1);
  }
}