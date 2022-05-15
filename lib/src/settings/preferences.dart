import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const limit = 20; // -1 to deactivate
  static const showONBOARDING = 'onboarding';
  static const locale = 'locale';

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> getShowOnboarding() async {
    final SharedPreferences prefs = await _prefs;
    final showOnboarding = prefs.getBool(showONBOARDING);
    return showOnboarding ?? true;
  }

  Future<void> setShowOnboarding(bool show) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(showONBOARDING, show);
  }

  Future<void> setLocale(Locale loc) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(locale, loc.languageCode);
  }

  Future<Locale?> getLocale() async {
    final SharedPreferences prefs = await _prefs;
    final loc = prefs.getString(locale);
    if (loc == null) return null;
    return Locale(loc);
  }
}
