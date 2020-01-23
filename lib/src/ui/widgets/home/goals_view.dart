import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../data/dto.dart';
import '../../../data/db.dart';
import '../../../store/home_store.dart';

class GoalsView extends StatefulWidget {
  @override
  _GoalsViewState createState() => _GoalsViewState();
}

class _GoalsViewState extends State<GoalsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<HomeStore>(
        builder: (_, HomeStore store, __) => Observer(
          builder: (_) => ListView(
            padding: EdgeInsets.all(20.0),
            children: store.goals.map((g) => GoalTile(g)).toList(),
          ),
        ),
      ),
    );
  }
}

class GoalTile extends StatelessWidget {
  final GoalWithTagsAndPomodorosCount goal;

  GoalTile(this.goal);

  @override
  Widget build(BuildContext context) {
    return _SlidableWrapper(
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

class _SlidableWrapper extends StatelessWidget {
  final Widget child;

  _SlidableWrapper({this.child});

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
