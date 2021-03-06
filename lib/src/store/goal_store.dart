import 'dart:async';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:wakelock/wakelock.dart';

import '../data/db.dart';
import '../data/db_repository.dart';
import '../utils/ticker.dart';

part 'goal_store.g.dart';

enum ETimerState {
  READY,
  PAUSE,
  RUN,
}

enum ETimerStage {
  WORK,
  REST,
  LONG_REST,
}

const int COUNT_WORK_LONG_REST_BEFORE = 4;

class GoalStore = _GoalStore with _$GoalStore;

abstract class _GoalStore with Store {
  Goal _goal;
  DbDataRepository _db;
  StreamSubscription<int> _tickerSubscription;

  final Ticker _ticker = Ticker();
  final AudioCache _player = new AudioCache(prefix: 'audio/');

  _GoalStore({
    DbDataRepository db,
  }) {
    _db = db ?? DbDataRepository.db();
  }

  init(Goal goal) {
    _goal = goal;
    _db.getPomodorosByGoal(goal).then(
          (result) => result.fold(
            (error) => _dbError = error.toString(),
            _setPomodoros,
          ),
        );

    _time = 1500;
    _timerState = ETimerState.READY;
  }

  @observable
  String _dbError = "";

  String get dbError => _dbError;

  @action
  void _setPomodoros(List<Pomodoro> pomodoros) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _todayPomodorosCount = pomodoros.where((p) {
      return p.date.isAfter(today);
    }).length;

    _allPomodorosCount = pomodoros.length;
  }

  String get label => _goal.label;

  @observable
  int _todayPomodorosCount;

  int get todayPomodorosCount => _todayPomodorosCount;

  @observable
  int _allPomodorosCount;

  int get allPomodorosCount => _allPomodorosCount;

  @action
  Future _addPomodoro() async {
    (await _db.createPomodoro(_goal)).fold(
      (error) => _dbError = error.toString(),
      (_) => print('pomodoro created'),
    );

    _todayPomodorosCount++;
    _allPomodorosCount++;
  }

  @observable
  int _workCount = 0;

  int get workCount => _workCount;

  @observable
  int _time = 1500;

  String get time {
    final String minutes =
        ((_time / 60) % 60).floor().toString().padLeft(2, '0');
    final String seconds = (_time % 60).floor().toString().padLeft(2, '0');

    return '$minutes : $seconds';
  }

  double get ratioTime {
    final full = _timerStage == ETimerStage.WORK
        ? 1500
        : _timerStage == ETimerStage.REST ? 300 : 900;

    return 1.0 - _time / full;
  }

  @observable
  ETimerState _timerState = ETimerState.READY;
  ETimerState get timerState => _timerState;

  @observable
  ETimerStage _timerStage = ETimerStage.WORK;
  ETimerStage get timerStage => _timerStage;

  @action
  setTime(int newTime) {
    _time = newTime;
    if (newTime == 0) {
      _doneTimer();
    }
  }

  // ui button handler
  @action
  doTimerAction() {
    switch (_timerState) {
      case ETimerState.RUN:
        _releaseWakeLock();
        _timerState = ETimerState.PAUSE;
        _pauseTimer();
        break;
      case ETimerState.PAUSE:
        _releaseWakeLock();
        _accureWakeLock();
        _timerState = ETimerState.RUN;
        _resumeTimer();
        break;
      case ETimerState.READY:
        _accureWakeLock();
        _timerState = ETimerState.RUN;
        _startTimer(_getTime(_timerStage));
        break;
    }
  }

  void _startTimer(int timerLength) {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: timerLength).listen((int time) => setTime(time));
  }

  void _pauseTimer() {
    _tickerSubscription?.cancel();
  }

  void _resumeTimer() {
    setTime(_time);
    _startTimer(_time);
  }

  void cleanTimer() {
    _tickerSubscription?.cancel();
    _releaseWakeLock();
  }

  @action
  void _doneTimer() {
    _timerState = ETimerState.READY;
    _releaseWakeLock();
    switch (_timerStage) {
      case ETimerStage.WORK:
        _addPomodoro();
        if (_workCount < COUNT_WORK_LONG_REST_BEFORE - 1) {
          _workCount++;
          _timerStage = ETimerStage.REST;
          _time = _getTime(_timerStage);
          _player.play("done.mp3");
          doTimerAction();
          break;
        }
        _workCount = 0;
        _timerStage = ETimerStage.LONG_REST;
        _time = _getTime(_timerStage);
        _player.play("done.mp3");
        doTimerAction();
        break;
      case ETimerStage.REST:
        _timerStage = ETimerStage.WORK;
        _time = _getTime(_timerStage);
        _player.play("bells.mp3");
        break;
      case ETimerStage.LONG_REST:
        _timerStage = ETimerStage.WORK;
        _time = _getTime(_timerStage);
        _player.play("bells.mp3");
        break;
    }
  }

  int _getTime(ETimerStage timerStage) {
    switch (timerStage) {
      case ETimerStage.WORK:
        return 1500;
      case ETimerStage.REST:
        return 300;
      case ETimerStage.LONG_REST:
        return 900;
      default:
        return 1500;
    }
  }

  Future _accureWakeLock() {
    return Wakelock.enable();
  }

  Future _releaseWakeLock() {
    return Wakelock.disable();
  }
}
