import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/dto.dart';
import '../../data/db_repository.dart';
import '../../store/goal_store.dart';

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
      child: _GoalScreen(),
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
        builder: (_) => Text('time...'),
      ),
    );
  }
}

class _TimerActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Observer(
        builder: (_) => IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {},
        ),
      ),
    );
  }
}
