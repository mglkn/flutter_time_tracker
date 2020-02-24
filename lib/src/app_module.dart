import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './utils/app_localization.dart';
import './utils/theme.dart';
import 'ui/screens/screens.dart';
import 'store/home_store.dart';

import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeStore()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, __) => HomeScreen()),
        Router('/goal', child: (_, __) => PlaceHolder()),
        Router('/goalForm', child: (_, __) => PlaceHolder()),
        Router('/tagForm', child: (_, __) => PlaceHolder()),
      ];

  @override
  Widget get bootstrap => App();
}

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

      // Theme
      theme: getGolbalTheme(context),

      // Routes
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}

class PlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('hello there'),
      ),
    );
  }
}
