// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:time_tracker/src/ui/screens/home_screen.dart';
import 'package:time_tracker/src/ui/screens/tag_form_screen.dart';
import 'package:time_tracker/src/ui/screens/goal_form_screen.dart';

class AppRouter {
  static const homeScreen = '/';
  static const tagFormScreen = '/tagFormScreen';
  static const goalFormScreen = '/goalFormScreen';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<AppRouter>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRouter.homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );
      case AppRouter.tagFormScreen:
        return MaterialPageRoute(
          builder: (_) => TagFormScreen(),
          settings: settings,
        );
      case AppRouter.goalFormScreen:
        return MaterialPageRoute(
          builder: (_) => GoalFormScreen(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
