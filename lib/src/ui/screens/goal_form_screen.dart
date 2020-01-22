import 'package:flutter/material.dart';

import '../../utils/app_localization.dart';

class GoalFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("createGoal").toUpperCase(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('goal form'),
      ),
    );
  }
}
