import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import 'package:plus_locate/src/shared/utils/constant.dart';

part 'saved_code.freezed.dart';

/// A Plus Code saved by the user for later reference.
///
/// Uses a manual Hive TypeAdapter for local persistence
/// (hive_generator removed from project).
@freezed
sealed class SavedCode with _$SavedCode {
  const SavedCode._();

  const factory SavedCode({
    /// Unique identifier (UUID or timestamp-based)
    String? id,

    /// The full global Plus Code
    String? globalCode,

    /// The short local Plus Code
    String? localCode,

    /// Latitude of the code location
    double? latitude,

    /// Longitude of the code location
    double? longitude,

    /// User-assigned label / note
    String? label,

    /// Locality name
    String? locality,

    /// Address name
    String? address,

    /// When the code was saved
    DateTime? savedAt,
  }) = _SavedCode;

  /// Display-friendly title: label if set, otherwise the global code.
  String get displayTitle => label ?? globalCode ?? 'Unknown Code';

  /// Whether this saved code has valid coordinates.
  bool get hasCoordinates => latitude != null && longitude != null;

  /// Manual fromJson — per standards.
  factory SavedCode.fromJson(Map<String, dynamic> json) {
    return SavedCode(
      id: json['id']?.toString(),
      globalCode: json['global_code']?.toString(),
      localCode: json['local_code']?.toString(),
      latitude: _parseDouble(json['latitude']),
      longitude: _parseDouble(json['longitude']),
      label: json['label']?.toString(),
      address: json['address']?.toString(),
      savedAt: convertJsonDate(json['saved_at']),
    );
  }

  static Map<String, dynamic> toJson(SavedCode item) {
    return {
      'id': item.id,
      'global_code': item.globalCode,
      'local_code': item.localCode,
      'latitude': item.latitude,
      'longitude': item.longitude,
      'label': item.label,
      'address': item.address,
      'saved_at': item.savedAt?.toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }

  static Map<String, dynamic> createPayload(SavedCode item) {
    return {
      'id': item.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      'global_code': item.globalCode,
      'local_code': item.localCode,
      'latitude': item.latitude,
      'longitude': item.longitude,
      'label': item.label,
      'address': item.address,
      'saved_at':
          item.savedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }

  static double? _parseDouble(value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}

/// Manual Hive TypeAdapter for [SavedCode].
/// Registered in AppInitializer.preAppRun().
class SavedCodeAdapter extends TypeAdapter<SavedCode> {
  @override
  final int typeId = 0;

  @override
  SavedCode read(BinaryReader reader) {
    final map = reader.readMap().cast<String, dynamic>();
    return SavedCode.fromJson(map);
  }

  @override
  void write(BinaryWriter writer, SavedCode obj) {
    writer.writeMap(SavedCode.toJson(obj));
  }
}
