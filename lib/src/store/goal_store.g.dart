// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GoalStore on _GoalStore, Store {
  final _$_dbErrorAtom = Atom(name: '_GoalStore._dbError');

  @override
  String get _dbError {
    _$_dbErrorAtom.context.enforceReadPolicy(_$_dbErrorAtom);
    _$_dbErrorAtom.reportObserved();
    return super._dbError;
  }

  @override
  set _dbError(String value) {
    _$_dbErrorAtom.context.conditionallyRunInAction(() {
      super._dbError = value;
      _$_dbErrorAtom.reportChanged();
    }, _$_dbErrorAtom, name: '${_$_dbErrorAtom.name}_set');
  }

  final _$_todayPomodorosCountAtom =
      Atom(name: '_GoalStore._todayPomodorosCount');

  @override
  int get _todayPomodorosCount {
    _$_todayPomodorosCountAtom.context
        .enforceReadPolicy(_$_todayPomodorosCountAtom);
    _$_todayPomodorosCountAtom.reportObserved();
    return super._todayPomodorosCount;
  }

  @override
  set _todayPomodorosCount(int value) {
    _$_todayPomodorosCountAtom.context.conditionallyRunInAction(() {
      super._todayPomodorosCount = value;
      _$_todayPomodorosCountAtom.reportChanged();
    }, _$_todayPomodorosCountAtom,
        name: '${_$_todayPomodorosCountAtom.name}_set');
  }

  final _$_allPomodorosCountAtom = Atom(name: '_GoalStore._allPomodorosCount');

  @override
  int get _allPomodorosCount {
    _$_allPomodorosCountAtom.context
        .enforceReadPolicy(_$_allPomodorosCountAtom);
    _$_allPomodorosCountAtom.reportObserved();
    return super._allPomodorosCount;
  }

  @override
  set _allPomodorosCount(int value) {
    _$_allPomodorosCountAtom.context.conditionallyRunInAction(() {
      super._allPomodorosCount = value;
      _$_allPomodorosCountAtom.reportChanged();
    }, _$_allPomodorosCountAtom, name: '${_$_allPomodorosCountAtom.name}_set');
  }

  final _$_workCountAtom = Atom(name: '_GoalStore._workCount');

  @override
  int get _workCount {
    _$_workCountAtom.context.enforceReadPolicy(_$_workCountAtom);
    _$_workCountAtom.reportObserved();
    return super._workCount;
  }

  @override
  set _workCount(int value) {
    _$_workCountAtom.context.conditionallyRunInAction(() {
      super._workCount = value;
      _$_workCountAtom.reportChanged();
    }, _$_workCountAtom, name: '${_$_workCountAtom.name}_set');
  }

  final _$_timeAtom = Atom(name: '_GoalStore._time');

  @override
  int get _time {
    _$_timeAtom.context.enforceReadPolicy(_$_timeAtom);
    _$_timeAtom.reportObserved();
    return super._time;
  }

  @override
  set _time(int value) {
    _$_timeAtom.context.conditionallyRunInAction(() {
      super._time = value;
      _$_timeAtom.reportChanged();
    }, _$_timeAtom, name: '${_$_timeAtom.name}_set');
  }

  final _$_timerStateAtom = Atom(name: '_GoalStore._timerState');

  @override
  ETimerState get _timerState {
    _$_timerStateAtom.context.enforceReadPolicy(_$_timerStateAtom);
    _$_timerStateAtom.reportObserved();
    return super._timerState;
  }

  @override
  set _timerState(ETimerState value) {
    _$_timerStateAtom.context.conditionallyRunInAction(() {
      super._timerState = value;
      _$_timerStateAtom.reportChanged();
    }, _$_timerStateAtom, name: '${_$_timerStateAtom.name}_set');
  }

  final _$_timerStageAtom = Atom(name: '_GoalStore._timerStage');

  @override
  ETimerStage get _timerStage {
    _$_timerStageAtom.context.enforceReadPolicy(_$_timerStageAtom);
    _$_timerStageAtom.reportObserved();
    return super._timerStage;
  }

  @override
  set _timerStage(ETimerStage value) {
    _$_timerStageAtom.context.conditionallyRunInAction(() {
      super._timerStage = value;
      _$_timerStageAtom.reportChanged();
    }, _$_timerStageAtom, name: '${_$_timerStageAtom.name}_set');
  }

  final _$_addPomodoroAsyncAction = AsyncAction('_addPomodoro');

  @override
  Future<dynamic> _addPomodoro() {
    return _$_addPomodoroAsyncAction.run(() => super._addPomodoro());
  }

  final _$_GoalStoreActionController = ActionController(name: '_GoalStore');

  @override
  void _setPomodoros(List<dynamic> pomodoros) {
    final _$actionInfo = _$_GoalStoreActionController.startAction();
    try {
      return super._setPomodoros(pomodoros);
    } finally {
      _$_GoalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTime(int newTime) {
    final _$actionInfo = _$_GoalStoreActionController.startAction();
    try {
      return super.setTime(newTime);
    } finally {
      _$_GoalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic doTimerAction() {
    final _$actionInfo = _$_GoalStoreActionController.startAction();
    try {
      return super.doTimerAction();
    } finally {
      _$_GoalStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _doneTimer() {
    final _$actionInfo = _$_GoalStoreActionController.startAction();
    try {
      return super._doneTimer();
    } finally {
      _$_GoalStoreActionController.endAction(_$actionInfo);
    }
  }
}
