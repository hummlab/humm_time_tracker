import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppConfig {
  static const String appName = 'Time Tracker';

  // Organization owner email - single organization mode (set your own)
  static const String ownerEmail = 'owner@example.com';

  // Hardcoded version as fallback (keep in sync with pubspec.yaml)
  static const String _fallbackVersion = '1.0.12';
  static const String _fallbackBuildNumber = '1';

  static PackageInfo? _packageInfo;
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    // On web, package_info_plus can be unreliable in release mode
    // Use fallback values instead of trying to load
    if (kIsWeb) {
      debugPrint('AppConfig: Using fallback version for web');
      return;
    }

    try {
      _packageInfo = await PackageInfo.fromPlatform();
    } catch (e) {
      debugPrint('AppConfig: Could not load package info: $e');
    }
  }

  static String get version => _packageInfo?.version ?? _fallbackVersion;
  static String get buildNumber => _packageInfo?.buildNumber ?? _fallbackBuildNumber;
  static String get fullVersion => 'v$version ($buildNumber)';
  static String get shortVersion => 'v$version';
}
