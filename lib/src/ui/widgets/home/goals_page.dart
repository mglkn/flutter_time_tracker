import 'package:flutter/material.dart';

import '../../../data/dto.dart';
import '../../../data/db.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final _listTestGoals = [
    GoalWithTagsAndPomodorosCount(
      goal: Goal(label: 'first goal'),
      tags: [],
      pomodorosCount: 12,
    ),
    GoalWithTagsAndPomodorosCount(
      goal: Goal(label: 'second goal'),
      tags: [],
      pomodorosCount: 12,
    ),
    GoalWithTagsAndPomodorosCount(
      goal: Goal(label: 'third goal'),
      tags: [],
      pomodorosCount: 12,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          ..._listTestGoals.map((g) => GoalTile(g)),
        ],
      ),
    );
  }
}

class GoalTile extends StatelessWidget {
  final GoalWithTagsAndPomodorosCount goal;

  GoalTile(this.goal);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(goal.pomodorosCount.toString()),
        title: Text(goal.goal.label),
      ),
    );
  }
}
