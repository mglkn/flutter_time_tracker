import 'package:flutter/material.dart';

import './routes/router.gr.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.homeScreen,
      navigatorKey: AppRouter.navigatorKey,
    );
  }
}
