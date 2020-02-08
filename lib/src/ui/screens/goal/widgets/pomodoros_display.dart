import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../store/goal_store.dart';
import '../../../../utils/app_localization.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/theme.dart';

class PomodorosDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Observer(
            builder: (_) => _PomodoroTile(
              label: AppLocalizations.of(context).translate('all'),
              pomodorosCount: store.allPomodorosCount ?? 0,
            ),
          ),
          Observer(
            builder: (_) => _PomodoroTile(
              label: AppLocalizations.of(context).translate('today'),
              pomodorosCount: store.todayPomodorosCount ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _PomodoroTile extends StatelessWidget {
  final int pomodorosCount;
  final String label;

  _PomodoroTile({
    this.pomodorosCount,
    this.label,
  })  : assert(pomodorosCount != null),
        assert(label != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.0,
      width: 125.0,
      decoration: tileDecoration.copyWith(color: Colors.red[400]),
      child: Stack(
        children: <Widget>[
          _PomodoroIcon(),
          _TileInfo(label: label, pomodorosCount: pomodorosCount),
        ],
      ),
    );
  }
}

class _PomodoroIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment(0, -.5),
      child: Icon(
        AppIcons.pomodoro,
        color: Colors.white,
        size: 90.0,
      ),
    );
  }
}

class _TileInfo extends StatelessWidget {
  final String label;
  final int pomodorosCount;

  _TileInfo({this.label, this.pomodorosCount})
      : assert(label != null),
        assert(pomodorosCount != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _TileInfoCount(pomodorosCount),
          const SizedBox(height: 15.0),
          // label
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.body1.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}

class _TileInfoCount extends StatelessWidget {
  final int pomodorosCount;

  _TileInfoCount(this.pomodorosCount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(
        pomodorosCount.toString(),
        style: Theme.of(context)
            .textTheme
            .subtitle
            .copyWith(fontSize: 30.0, color: Colors.white),
      ),
    );
  }
}
