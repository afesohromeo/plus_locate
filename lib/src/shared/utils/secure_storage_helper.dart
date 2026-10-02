import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  /// resetOnError: data restored from a backup on another device can't be
  /// decrypted (its keys stay in the old device's keystore); wipe it instead
  /// of failing every read.
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(resetOnError: true),
  );
  static const kUser = 'user';

  static const kToken = 'token';
  static const kRole = 'roles';

  static const kAuthorization = 'authorizations';

  static Future<void> saveToken(var token) async {
    await _storage.write(key: kToken, value: token);
  }

  static Future<void> saveUser(var user) async {
    await _storage.write(key: kUser, value: user);
  }

  static Future<void> saveRoles(var roles) async {
    await _storage.write(key: kRole, value: roles);
  }

  static Future<void> saveAuthorizations(var authorizations) async {
    await _storage.write(key: kAuthorization, value: authorizations);
  }

  static Future<String?> getToken() async {
    return (await _storage.read(key: kToken)) ?? '';
  }

  static Future<String?> getUser() async {
    return (await _storage.read(key: kUser)) ?? '';
  }

  static Future<String?> getRoles() async {
    return (await _storage.read(key: kRole)) ?? '';
  }

  static Future<String?> getAuthorizations() async {
    return (await _storage.read(key: kAuthorization)) ?? '';
  }

  static Future<void> clearAll() async {
    // final baseUrl = await getBaseUrl();
    await _storage.deleteAll();

    // await saveBaseUrl(baseUrl);
  }

  static const kHasSeenOnboarding = 'hasSeenOnboarding';

  /// Read on every navigation by the router's redirect, so it must never
  /// throw: an unreadable flag means onboarding shows once more.
  static Future<bool> hasSeenOnboarding() async {
    try {
      final value = await _storage.read(key: kHasSeenOnboarding);
      return value == 'true';
    } catch (e) {
      log('Could not read onboarding flag: $e');
      return false;
    }
  }

  /// Best-effort: if it fails, onboarding just shows again next launch.
  static Future<void> markOnboardingSeen() async {
    try {
      await _storage.write(key: kHasSeenOnboarding, value: 'true');
    } catch (e) {
      log('Could not save onboarding flag: $e');
    }
  }
}
