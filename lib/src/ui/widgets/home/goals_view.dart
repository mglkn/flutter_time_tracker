import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../data/dto.dart';
import '../../../data/db.dart';
import '../../../store/home_store.dart';
import '../../../routes/router.gr.dart';
import '../../../utils/theme.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_localization.dart';

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
          builder: (_) => store.goals.length == 0
              ? Center(
                  child: Text(
                    AppLocalizations.of(context).translate('nogoals'),
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 26.0, color: Colors.grey[500]),
                  ),
                )
              : ListView(
                  padding: EdgeInsets.all(30.0),
                  children: store.goals.map((g) => _Tile(g)).toList(),
                ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final GoalWithTagsAndPomodorosCount goal;

  _Tile(this.goal);

  Future _navigateToGoal(BuildContext context) async {
    await AppRouter.navigator
        .pushNamed(AppRouter.goalScreen, arguments: this.goal);

    HomeStore store = Provider.of<HomeStore>(context, listen: false);
    await store.getGoals();
    await store.getTags();
  }

  @override
  Widget build(BuildContext context) {
    return _SlidableWrapper(
      goal: goal,
      child: GestureDetector(
        onTap: goal.goal.isDone ? null : () => _navigateToGoal(context),
        child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
          margin: EdgeInsets.only(bottom: 15.0),
          decoration: goal.goal.isDone ? doneTileDecoration : tileDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _TilePomodorosCount(goal.pomodorosCount),
              _TileContent(
                label: goal.goal.label,
                tags: goal.tags,
                isDone: goal.goal.isDone,
              ),
            ],
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
    final edit = AppLocalizations.of(context).translate('doEdit');
    final done = AppLocalizations.of(context).translate('doDone');
    final resume = AppLocalizations.of(context).translate('doResume');

    return Consumer(
      builder: (_, HomeStore store, __) => Slidable(
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.2,
        actions: <Widget>[
          IconSlideAction(
            caption: edit,
            color: Colors.transparent,
            foregroundColor: Colors.black,
            icon: Icons.edit,
            onTap: () {
              AppRouter.navigator
                  .pushNamed(AppRouter.goalFormScreen, arguments: goal);
            },
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: store.isGoalDone ? resume : done,
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

class _TilePomodorosCount extends StatelessWidget {
  final int pomodoroCount;

  _TilePomodorosCount(this.pomodoroCount) : assert(pomodoroCount != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, -.2),
            child: Icon(
              AppIcons.pomodoro,
              color: Colors.white,
              size: 42.0,
            ),
          ),
          Align(
            alignment: Alignment(0, .2),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                color: Colors.red[400],
              ),
              child: Text(
                pomodoroCount.toString(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TileContent extends StatelessWidget {
  final String label;
  final List<Tag> tags;
  final bool isDone;

  _TileContent({this.label, this.tags, this.isDone})
      : assert(label != null),
        assert(tags != null),
        assert(isDone != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO: move magic numbers to constants
      // 60 - padding ListView
      // 60 - width pomodoroCount
      // 15 - right padding TileContent?
      // 2 - tile border
      // 5.0 - this padding
      padding: EdgeInsets.only(left: 5.0),
      width: MediaQuery.of(context).size.width - 60.0 - 60.0 - 15.0 - 2.0 - 5.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 18.0,
                  fontFamily: 'FiraSans',
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
          ),
          SizedBox(height: 5.0),
          Wrap(
            children: tags.map((t) => _TagListTile(t)).toList(),
            spacing: 2.0,
            runSpacing: 2.0,
          ),
        ],
      ),
    );
  }
}

class _TagListTile extends StatelessWidget {
  final Tag tag;

  _TagListTile(this.tag);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, HomeStore store, __) => Container(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
        decoration: BoxDecoration(
          color: Color(tag.color),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Text(
          tag.label,
          style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 11.0,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
