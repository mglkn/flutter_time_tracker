import 'package:flutter/material.dart';

import 'tag_selector.dart';
import 'input_goal_label.dart';

class GoalForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * .9,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InputGoalLabel(),
            const SizedBox(height: 20.0),
            Expanded(
              child: TagSelector(),
            ),
          ],
        ),
      ),
    );
  }
}
