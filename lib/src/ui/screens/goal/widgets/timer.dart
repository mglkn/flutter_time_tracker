import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../store/goal_store.dart';
import '../../../../utils/app_localization.dart';
import '../../../../utils/theme.dart';

const double timerSize = 220.0;

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => GestureDetector(
        onTap: store.doTimerAction,
        child: Stack(
          children: <Widget>[
            _Timer(),
            _TimerDynamicBorder(),
          ],
        ),
      ),
    );
  }
}

class _Timer extends StatelessWidget {
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
              _TimerStateAction(),
              _TimerClock(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerStateAction extends StatelessWidget {
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

class _TimerClock extends StatelessWidget {
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
                  .translate(_getStage(store.timerStage))
                  .toUpperCase(),
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

class _TimerDynamicBorder extends StatelessWidget {
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
    return tickTimer != old.tickTimer ||
        color != old.color ||
        bgColor != old.bgColor;
  }
}
