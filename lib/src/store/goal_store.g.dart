// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GoalStore on _GoalStore, Store {
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

  final _$addPomodoroAsyncAction = AsyncAction('addPomodoro');

  @override
  Future<dynamic> addPomodoro() {
    return _$addPomodoroAsyncAction.run(() => super.addPomodoro());
  }
}
