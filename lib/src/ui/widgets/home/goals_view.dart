import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../data/dto.dart';
import '../../../data/db.dart';
import '../../../store/home_store.dart';
import '../../../routes/router.gr.dart';

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

  void _navigateToGoal() {
    AppRouter.navigator
        .pushNamed(AppRouter.goalScreen, arguments: this.goal.goal.id);
  }

  @override
  Widget build(BuildContext context) {
    return _SlidableWrapper(
      goal: goal,
      child: Card(
        child: ListTile(
          onTap: _navigateToGoal,
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
  final GoalWithTagsAndPomodorosCount goal;

  _SlidableWrapper({this.child, this.goal})
      : assert(child != null),
        assert(goal != null);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, HomeStore store, __) => Slidable(
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.2,
        actions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.transparent,
            foregroundColor: Colors.black,
            icon: Icons.done,
            onTap: () {
              AppRouter.navigator
                  .pushNamed(AppRouter.goalFormScreen, arguments: goal);
            },
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: store.isGoalDoneFlag ? 'Undone' : 'Done',
            color: Colors.transparent,
            foregroundColor: Colors.black,
            icon: Icons.done,
            onTap: () {
              store.toggleGoalStatus(goal);
            },
          ),
        ],
        child: child,
      ),
    );
  }
}

class TagListTile extends StatelessWidget {
  final Tag tag;

  TagListTile(this.tag);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, HomeStore store, __) => Opacity(
        opacity: store.isGoalDoneFlag ? 0.5 : 1.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          margin: EdgeInsets.only(right: 2.0, bottom: 2.0),
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
        ),
      ),
    );
  }
}
