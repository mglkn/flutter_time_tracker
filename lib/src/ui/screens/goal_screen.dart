import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class GoalScreen extends StatelessWidget {
  final int goalId;

  GoalScreen({@required this.goalId}) : assert(goalId != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Goal screen $goalId'),
      ),
    );
  }
}
