import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../data/dto.dart';
import '../../../../data/db.dart';
import '../../../../store/home_store.dart';
import '../../../../routes/router.gr.dart';
import '../../../../utils/theme.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_localization.dart';

const listViewPadding = 30.0;
const tilePomodoroCountSize = 60.0;
const tilePadding = 5.0;
const tileContentLeftPadding = 5.0;
const tileBorder = 1.0;
const tileContentWidthDiff = (listViewPadding * 2) +
    tilePomodoroCountSize +
    tileContentLeftPadding +
    (tilePadding * 2) +
    (tileBorder * 2);

class GoalTile extends StatelessWidget {
  final GoalWithTagsAndPomodorosCount goal;

  GoalTile(this.goal);

  Future _navigateToGoal(BuildContext context) async {
    await AppRouter.navigator
        .pushNamed(AppRouter.goalScreen, arguments: this.goal);

    final HomeStore store = Modular.get<HomeStore>();
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
          padding: EdgeInsets.all(tilePadding),
          margin: EdgeInsets.only(bottom: 10.0),
          decoration:
              (goal.goal.isDone ? doneTileDecoration : tileDecoration).copyWith(
            border: Border.all(
              width: tileBorder,
              color: Colors.grey[200],
            ),
          ),
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
    final HomeStore store = Modular.get<HomeStore>();

    return Slidable(
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
    );
  }
}

class _TilePomodorosCount extends StatelessWidget {
  final int pomodoroCount;

  _TilePomodorosCount(this.pomodoroCount) : assert(pomodoroCount != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tilePomodoroCountSize,
      height: tilePomodoroCountSize,
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(3.0),
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
                    .subtitle2
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
      padding: EdgeInsets.only(left: tileContentLeftPadding),
      width: MediaQuery.of(context).size.width - tileContentWidthDiff,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: 'goal_title_$label',
            child: Text(
              label,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: 20.0,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      decoration: BoxDecoration(
        color: Color(tag.color),
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Text(
        tag.label,
        style: Theme.of(context).textTheme.subtitle2.copyWith(
              fontSize: 11.0,
              color: Colors.white,
            ),
      ),
    );
  }
}
