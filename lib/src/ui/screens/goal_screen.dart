import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/dto.dart';
import '../../data/db_repository.dart';
import '../../store/goal_store.dart';
import '../../utils/app_localization.dart';

class GoalScreen extends StatelessWidget {
  final GoalWithTagsAndPomodorosCount goal;

  GoalScreen({@required this.goal}) : assert(goal != null);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => GoalStore(
        db: DbDataRepository.db(),
        goal: goal.goal,
      ),
      child: _EscapePreventerWrapper(
        child: _GoalScreen(),
      ),
    );
  }
}

class _GoalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Scaffold(
        appBar: AppBar(
          title: Text(store.label),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 50.0),
            _Pomodoros(),
            const SizedBox(height: 50.0),
            _Timer(),
          ],
        ),
      ),
    );
  }
}

class _Pomodoros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Observer(
            builder: (_) => Text('all ${store.allPomodorosCount}'),
          ),
          Observer(
            builder: (_) => Text('today ${store.todayPomodorosCount}'),
          ),
        ],
      ),
    );
  }
}

class _Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _TimerClock(),
        _TimerActions(),
      ],
    );
  }
}

class _TimerClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Observer(
        builder: (_) => Text(
          store.time,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _TimerActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => IconButton(
        icon: Observer(
          builder: (_) {
            return Icon(_getIcon(store.timerState));
          },
        ),
        onPressed: store.doTimerAction,
      ),
    );
  }

  IconData _getIcon(ETimerState timerState) {
    if (timerState == ETimerState.RUN) {
      return Icons.pause;
    }

    return Icons.play_arrow;
  }
}

class _EscapePreventerWrapper extends StatelessWidget {
  final Widget child;

  _EscapePreventerWrapper({
    @required this.child,
  }) : assert(child != null);

  Future<bool> _onWillPop(BuildContext context) {
    GoalStore store = Provider.of<GoalStore>(context, listen: false);

    if (store.timerState != ETimerState.READY) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            AppLocalizations.of(context).translate('escapeGoalTitle'),
          ),
          content: Text(
            AppLocalizations.of(context).translate('escapeGoalContent'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                AppLocalizations.of(context).translate('yes'),
              ),
              onPressed: () {
                store.cleanTimer();
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text(
                AppLocalizations.of(context).translate('no'),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      );
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: child,
    );
  }
}
