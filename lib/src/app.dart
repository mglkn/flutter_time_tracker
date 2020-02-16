import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './routes/router.gr.dart';
import './utils/app_localization.dart';
import './utils/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Localization
      supportedLocales: [
        Locale("en"),
        Locale("ru"),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },

      // Routes
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.homeScreen,
      navigatorKey: AppRouter.navigatorKey,

      // Theme
      theme: getGolbalTheme(context),
    );
  }
}
