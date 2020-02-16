import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../../store/goal_store.dart';
import '../../../../utils/app_localization.dart';
import '../../../../utils/theme.dart';

const double timerSize = 220.0;

class Timer extends StatelessWidget {
  final tween = MultiTrackTween([
    Track('color_main').add(
      Duration(milliseconds: 300),
      ColorTween(begin: Colors.red[300], end: Colors.green[300]),
    ),
    Track('color_dark').add(
      Duration(milliseconds: 300),
      ColorTween(begin: Colors.red[600], end: Colors.green[300]),
    ),
    Track('color_light').add(
      Duration(milliseconds: 300),
      ColorTween(begin: Colors.red[200], end: Colors.green[200]),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => GestureDetector(
        onTap: store.doTimerAction,
        child: Observer(
          builder: (_) => ControlledAnimation(
            playback: store.timerStage == ETimerStage.WORK
                ? Playback.PLAY_REVERSE
                : Playback.PLAY_FORWARD,
            duration: const Duration(milliseconds: 300),
            tween: tween,
            builder: (_, animation) => Stack(
              children: <Widget>[
                _Timer(animation['color_main']),
                _TimerDynamicBorder(
                  colorDark: animation['color_dark'],
                  colorLight: animation['color_light'],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Timer extends StatelessWidget {
  final Color colorMain;

  _Timer(this.colorMain);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Observer(
        builder: (_) => Container(
          height: timerSize,
          width: timerSize,
          decoration: tileDecoration.copyWith(
            color: colorMain,
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
              color: Theme.of(context).backgroundColor,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Observer(
              builder: (_) => Text(
                store.time,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Theme.of(context).backgroundColor,
                      fontSize: 34.0,
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              AppLocalizations.of(context)
                  .translate(_getStage(store.timerStage))
                  .toUpperCase(),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 28.0,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class _TimerDynamicBorder extends StatelessWidget {
  final Color colorDark;
  final Color colorLight;

  _TimerDynamicBorder({
    this.colorLight,
    this.colorDark,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Container(
        width: timerSize,
        height: timerSize,
        child: Observer(
          builder: (_) => CustomPaint(
            painter: _TimerPainter(
              bgColor: colorDark,
              color: colorLight,
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
