import 'package:meta/meta.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/dto.dart';
import '../../data/db_repository.dart';
import '../../store/goal_store.dart';
import '../../utils/app_localization.dart';
import '../../utils/app_icons.dart';
import '../../utils/theme.dart';

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
          title: Text(
            store.label,
            style: Theme.of(context).textTheme.title,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              _PomodorosDisplay(),
              const SizedBox(height: 50.0),
              _Timer(),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _PomodorosDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Observer(
            builder: (_) => _PomodoroTile(
              label: AppLocalizations.of(context).translate('all'),
              pomodorosCount: store.allPomodorosCount,
            ),
          ),
          Observer(
            builder: (_) => _PomodoroTile(
              label: AppLocalizations.of(context).translate('today'),
              pomodorosCount: store.todayPomodorosCount,
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
      decoration: tileDecoration.copyWith(
        color: Colors.red[400],
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, -.5),
            child: Icon(
              AppIcons.pomodoro,
              color: Colors.white,
              size: 90.0,
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    pomodorosCount.toString().toUpperCase(),
                    // 310.toString(),
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(height: 15.0),
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
          )
        ],
      ),
    );
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

const double timerSize = 220.0;

class _Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => GestureDetector(
        onTap: store.doTimerAction,
        child: Stack(
          children: <Widget>[
            _TimerMeta(),
            _TimerBorderPaint(),
          ],
        ),
      ),
    );
  }
}

class _TimerMeta extends StatelessWidget {
  Color _getColor({ETimerStage stage, int opacity}) {
    if (stage == ETimerStage.WORK) {
      return Colors.red[opacity];
    }
    return Colors.green[opacity];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Observer(
        builder: (_) => Container(
          height: timerSize,
          width: timerSize,
          decoration: tileDecoration.copyWith(
            color: _getColor(
              stage: store.timerStage,
              opacity: 300,
            ),
            borderRadius: BorderRadius.circular(timerSize / 2),
          ),
          child: Stack(
            children: <Widget>[
              _TimerMetaStateAction(),
              _TimerInfo(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerMetaStateAction extends StatelessWidget {
  IconData _getIcon(ETimerState timerState) {
    if (timerState == ETimerState.RUN) {
      return Icons.pause;
    }

    return Icons.play_arrow;
  }

  Color _getColor({ETimerStage stage, int opacity}) {
    if (stage == ETimerStage.WORK) {
      return Colors.red[opacity];
    }
    return Colors.green[opacity];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Container(
        width: timerSize,
        height: timerSize,
        child: Center(
          child: Observer(
            builder: (_) => Icon(
              _getIcon(store.timerState),
              color: _getColor(stage: store.timerStage, opacity: 400),
              size: timerSize * 0.7,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerInfo extends StatelessWidget {
  String _getStage(ETimerStage stage) {
    if (stage == ETimerStage.WORK) {
      return 'work';
    }
    return 'rest';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Observer(
              builder: (_) => Text(
                store.time,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              AppLocalizations.of(context)
                  .translate(_getStage(store.timerStage)),
              style: Theme.of(context).textTheme.body1.copyWith(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class _TimerBorderPaint extends StatelessWidget {
  Color _getColor({ETimerStage stage, int opacity}) {
    if (stage == ETimerStage.WORK) {
      return Colors.red[opacity];
    }
    return Colors.green[opacity];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Container(
        width: timerSize,
        height: timerSize,
        child: Observer(
          builder: (_) => CustomPaint(
            painter: _TimerPainter(
              bgColor: _getColor(
                stage: store.timerStage,
                opacity: 600,
              ),
              color: _getColor(
                stage: store.timerStage,
                opacity: 200,
              ),
              tickTimer: store.ratioTime,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimerPainter extends CustomPainter {
  final Color bgColor;
  final Color color;
  final double tickTimer;

  _TimerPainter({
    this.bgColor,
    this.color,
    this.tickTimer,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = bgColor
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;

    double progress = (1.0 - tickTimer) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(_TimerPainter old) {
    // return animation.value != old.animation.value ||
    return tickTimer != old.tickTimer ||
        color != old.color ||
        bgColor != old.bgColor;
  }
}
