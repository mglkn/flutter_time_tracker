import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      tags: [
        Tag(label: 'programming', color: Colors.purple.value),
        Tag(label: 'dart', color: Colors.blue.value),
        Tag(label: 'flutter', color: Colors.orange.value),
      ],
      pomodorosCount: 11,
    ),
    GoalWithTagsAndPomodorosCount(
      goal: Goal(label: 'second goal'),
      tags: [
        Tag(label: 'programming', color: Colors.purple.value),
        Tag(label: 'algorithms', color: Colors.teal.value),
        Tag(label: 'swift', color: Colors.red.value),
      ],
      pomodorosCount: 122,
    ),
    GoalWithTagsAndPomodorosCount(
      goal: Goal(label: 'third goal'),
      tags: [
        Tag(label: 'programming', color: Colors.purple.value),
        Tag(label: 'javascript', color: Colors.grey.value),
      ],
      pomodorosCount: 34,
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
    return SlidableWrapper(
      child: Card(
        child: ListTile(
          leading: Text(
            goal.pomodorosCount.toString(),
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          title: Text(goal.goal.label),
          subtitle: Wrap(
            children: goal.tags.map((t) => TagListTile(t)).toList(),
          ),
        ),
      ),
    );
  }
}

class SlidableWrapper extends StatelessWidget {
  final Widget child;

  SlidableWrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.2,
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.transparent,
          foregroundColor: Colors.black,
          icon: Icons.done,
          onTap: () {
            print("done");
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Done',
          color: Colors.transparent,
          foregroundColor: Colors.black,
          icon: Icons.done,
          onTap: () {
            print("done");
          },
        ),
      ],
      child: child,
    );
  }
}

class TagListTile extends StatelessWidget {
  final Tag tag;

  TagListTile(this.tag);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      margin: EdgeInsets.only(right: 2.0),
      decoration: BoxDecoration(
        color: Color(tag.color),
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        tag.label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.0,
        ),
      ),
    );
  }
}
