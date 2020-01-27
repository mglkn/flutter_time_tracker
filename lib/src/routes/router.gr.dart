// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:time_tracker/src/ui/screens/home_screen.dart';
import 'package:time_tracker/src/ui/screens/tag_form_screen.dart';
import 'package:time_tracker/src/data/dto.dart';
import 'package:time_tracker/src/ui/screens/goal_form_screen.dart';
import 'package:time_tracker/src/ui/screens/goal_screen.dart';

class AppRouter {
  static const homeScreen = '/';
  static const tagFormScreen = '/tagFormScreen';
  static const goalFormScreen = '/goalFormScreen';
  static const goalScreen = '/goalScreen';
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
        if (hasInvalidArgs<TagWithPomodorosCount>(args)) {
          return misTypedArgsRoute<TagWithPomodorosCount>(args);
        }
        final typedArgs = args as TagWithPomodorosCount;
        return MaterialPageRoute(
          builder: (_) => TagFormScreen(tag: typedArgs),
          settings: settings,
        );
      case AppRouter.goalFormScreen:
        if (hasInvalidArgs<GoalWithTagsAndPomodorosCount>(args)) {
          return misTypedArgsRoute<GoalWithTagsAndPomodorosCount>(args);
        }
        final typedArgs = args as GoalWithTagsAndPomodorosCount;
        return MaterialPageRoute(
          builder: (_) => GoalFormScreen(goal: typedArgs),
          settings: settings,
        );
      case AppRouter.goalScreen:
        if (hasInvalidArgs<int>(args)) {
          return misTypedArgsRoute<int>(args);
        }
        final typedArgs = args as int;
        return MaterialPageRoute(
          builder: (_) => GoalScreen(goalId: typedArgs),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
