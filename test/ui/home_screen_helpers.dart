import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:time_tracker/src/store/home_store.dart';
import 'package:time_tracker/src/utils/app_localization.dart';

import '../helpers/mocks.dart';

HomeStore getHomeStoreMock() {
  final repo = getDBRepoWithGoalsAndTagsMocked();
  return HomeStore(repo: repo);
}

var _localizedStringsCache;
Future<Map<String, String>> _getLocalizedStrings() async {
  if (_localizedStringsCache != null) {
    return _localizedStringsCache;
  }
  final String jsonString = await rootBundle.loadString("lang/en.json");
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  _localizedStringsCache =
      jsonMap.map((key, value) => MapEntry(key, value.toString()));
  return _localizedStringsCache;
}

Future<Widget> wrapMaterialApp(Widget child) async {
  return MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegateTest(await _getLocalizedStrings()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: child,
    ),
  );
}
