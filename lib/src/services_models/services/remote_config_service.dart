import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:padel/functions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RemoteConfigService {
  static Uri APP_STORE_URL =
      Uri.parse('https://apps.apple.com/dz/app/praticpower/id1606012558');
  static Uri PLAY_STORE_URL = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.optasoft.praticpower');
  static String? _version;
  static bool? _maintenanceBreak;
  static bool _done = false;
  static FirebaseRemoteConfig? _remoteConfig;

  static String? get version => _version;
  static void setVersion(String value) {
    _version = value;
  }

  static bool? get maintenanceBreak => _maintenanceBreak;
  static void setMaintenanceBreak(bool value) {
    _maintenanceBreak = value;
  }

  static bool? get done => _done;
  static void setDone(bool value) {
    _done = value;
  }

  static Future<bool> setup(BuildContext context) async {
    if (_remoteConfig == null) {
      _remoteConfig = FirebaseRemoteConfig.instance;
      await _remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 2),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      await _remoteConfig!.setDefaults(
        <String, dynamic>{
          breakName: false,
          versionName: Platform.isAndroid ? '1.0.0' : '1.0.0',
        },
      );
      RemoteConfigValue(null, ValueSource.valueStatic);
      try {
        await _remoteConfig!.fetchAndActivate();
      } catch (e) {
        log('Unable to fetch remote config. Cached or default values will be        used');
      }
      _maintenanceBreak = _remoteConfig!.getBool(breakName);
      _version = _remoteConfig!.getString(versionName);
      // if (true) {
      if (_maintenanceBreak == true) {
        showOneButtonDialog(
            context: context,
            title: AppLocalizations.of(context)!.alert_maintenance_title,
            content: AppLocalizations.of(context)!.alert_maintenance_subtitle,
            onClick: () {
              SystemNavigator.pop();
            });
        setDone(true);
        return true;
      }
      final PackageInfo info = await PackageInfo.fromPlatform();
      double currentVersion =
          double.parse(info.version.trim().replaceAll('.', ''));
      double newVersion = double.parse(_version!.trim().replaceAll('.', ''));
      log('remote version:$_version');
      log('current version:${info.version}');
      if (newVersion > currentVersion) {
        showOneButtonDialog(
            context: context,
            title: AppLocalizations.of(context)!.alert_update_title,
            content: AppLocalizations.of(context)!.alert_update_subtitle,
            label: AppLocalizations.of(context)!.update,
            onClick: () =>
                launchUrl(Platform.isIOS ? APP_STORE_URL : PLAY_STORE_URL));
        setDone(true);
        return true;
      }
      return false;
    }
    return false;
  }

  static String get versionName {
    if (Platform.isAndroid) {
      return 'AndroidVersion';
    } else {
      return 'iOSVersion';
    }
  }

  static String get breakName {
    if (Platform.isAndroid) {
      return 'AndroidBreak';
    } else {
      return 'iOSBreak';
    }
  }
}
