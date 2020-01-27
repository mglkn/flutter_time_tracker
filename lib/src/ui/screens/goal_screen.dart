import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import '../../data/dto.dart';

class GoalScreen extends StatelessWidget {
  final GoalWithTagsAndPomodorosCount goal;

  GoalScreen({@required this.goal}) : assert(goal != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Goal screen ${goal.label}'),
      ),
    );
  }
}
