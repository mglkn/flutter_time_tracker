import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'ui/screens/screens.dart';
import 'store/store.dart';

class AppModule extends MainModule {
  final Widget app;

  AppModule(this.app) : assert(app != null);

  @override
  List<Bind> get binds => [
        Bind<HomeStore>((i) => HomeStore()),
        Bind<GoalStore>((i) => GoalStore()),
        Bind<GoalFormStore>(
            (i) => GoalFormStore(homeStore: i.get<HomeStore>())),
        Bind<TagFormStore>((i) => TagFormStore(homeStore: i.get<HomeStore>()))
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, __) => HomeScreen()),
        Router(
          '/goal',
          child: (_, args) => GoalScreen(goal: args.data),
        ),
        Router(
          '/goalForm',
          child: (_, args) => GoalFormScreen(goal: args.data),
        ),
        Router(
          '/tagForm',
          child: (_, args) => TagFormScreen(tag: args.data),
        ),
      ];

  @override
  Widget get bootstrap => app;
}
