import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:time_tracker/src/data/db_repository.dart';
import 'package:time_tracker/src/data/dto.dart';
import 'package:time_tracker/src/data/db.dart';
import 'package:time_tracker/src/store/home_store.dart';
import 'package:time_tracker/src/utils/app_localization.dart';

import '../helpers/mocks.dart';

HomeStore getHomeStoreMock() {
  final repo = getDBRepoWithGoalsAndTagsMocked();
  return HomeStore(repo: repo);
}

Widget wrapMaterialApp(Widget child) {
  return MaterialApp(
    // Localization
    supportedLocales: [
      Locale("en", "EN"),
      Locale("ru", "RU"),
    ],
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    localeResolutionCallback: (locale, supportedLocales) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode &&
            supportedLocale.countryCode == locale.countryCode) {
          return supportedLocale;
        }
      }
      return supportedLocales.first;
    },

    home: child,
  );
}
