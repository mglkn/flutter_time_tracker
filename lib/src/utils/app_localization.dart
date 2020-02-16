import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static LocalizationsDelegate<AppLocalizations> delegateTest(
      Map<String, String> localizedStrings) {
    return _AppLocalizationsDelegate(testData: localizedStrings);
  }

  Map<String, String> _localizedStrings;

  Future load() async {
    String jsonString =
        await rootBundle.loadString("lang/${locale.languageCode}.json");

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }

  loadTest(localizedStrings) {
    _localizedStrings = localizedStrings;
  }

  String translate(String key) => _localizedStrings[key];
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Map<String, String> testData;

  const _AppLocalizationsDelegate({this.testData});

  @override
  bool isSupported(Locale locale) {
    return ["en"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalization = new AppLocalizations(locale);
    if (testData != null) {
      appLocalization.loadTest(testData);
    } else {
      await appLocalization.load();
    }
    return appLocalization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
