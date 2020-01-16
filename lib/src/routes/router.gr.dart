// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:time_tracker/src/ui/screens/goals_screen.dart';
import 'package:time_tracker/src/ui/screens/tags_screen.dart';
import 'package:time_tracker/src/ui/screens/test_screen.dart';

class AppRouter {
  static const goalsScreen = '/';
  static const tagsScreen = '/tagsScreen';
  static const testScreen = '/testScreen';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<AppRouter>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRouter.goalsScreen:
        return MaterialPageRoute(
          builder: (_) => GoalsScreen(),
          settings: settings,
        );
      case AppRouter.tagsScreen:
        return MaterialPageRoute(
          builder: (_) => TagsScreen(),
          settings: settings,
        );
      case AppRouter.testScreen:
        if (hasInvalidArgs<TestScreenArguments>(args)) {
          return misTypedArgsRoute<TestScreenArguments>(args);
        }
        final typedArgs = args as TestScreenArguments ?? TestScreenArguments();
        return MaterialPageRoute(
          builder: (_) => TestScreen(
              someNum: typedArgs.someNum, someNames: typedArgs.someNames),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//TestScreen arguments holder class
class TestScreenArguments {
  final int someNum;
  final List<String> someNames;
  TestScreenArguments({this.someNum, this.someNames});
}
