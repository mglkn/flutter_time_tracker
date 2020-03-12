// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$_goalsAtom = Atom(name: '_HomeStore._goals');

  @override
  ObservableList<GoalWithTagsAndPomodorosCount> get _goals {
    _$_goalsAtom.context.enforceReadPolicy(_$_goalsAtom);
    _$_goalsAtom.reportObserved();
    return super._goals;
  }

  @override
  set _goals(ObservableList<GoalWithTagsAndPomodorosCount> value) {
    _$_goalsAtom.context.conditionallyRunInAction(() {
      super._goals = value;
      _$_goalsAtom.reportChanged();
    }, _$_goalsAtom, name: '${_$_goalsAtom.name}_set');
  }

  final _$_tagsAtom = Atom(name: '_HomeStore._tags');

  @override
  ObservableList<TagWithPomodorosCount> get _tags {
    _$_tagsAtom.context.enforceReadPolicy(_$_tagsAtom);
    _$_tagsAtom.reportObserved();
    return super._tags;
  }

  @override
  set _tags(ObservableList<TagWithPomodorosCount> value) {
    _$_tagsAtom.context.conditionallyRunInAction(() {
      super._tags = value;
      _$_tagsAtom.reportChanged();
    }, _$_tagsAtom, name: '${_$_tagsAtom.name}_set');
  }

  final _$_goalStatusAtom = Atom(name: '_HomeStore._goalStatus');

  @override
  EGoalStatus get _goalStatus {
    _$_goalStatusAtom.context.enforceReadPolicy(_$_goalStatusAtom);
    _$_goalStatusAtom.reportObserved();
    return super._goalStatus;
  }

  @override
  set _goalStatus(EGoalStatus value) {
    _$_goalStatusAtom.context.conditionallyRunInAction(() {
      super._goalStatus = value;
      _$_goalStatusAtom.reportChanged();
    }, _$_goalStatusAtom, name: '${_$_goalStatusAtom.name}_set');
  }

  final _$_pageIndexAtom = Atom(name: '_HomeStore._pageIndex');

  @override
  int get _pageIndex {
    _$_pageIndexAtom.context.enforceReadPolicy(_$_pageIndexAtom);
    _$_pageIndexAtom.reportObserved();
    return super._pageIndex;
  }

  @override
  set _pageIndex(int value) {
    _$_pageIndexAtom.context.conditionallyRunInAction(() {
      super._pageIndex = value;
      _$_pageIndexAtom.reportChanged();
    }, _$_pageIndexAtom, name: '${_$_pageIndexAtom.name}_set');
  }

  final _$_dbErrorAtom = Atom(name: '_HomeStore._dbError');

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

  final _$getGoalsAsyncAction = AsyncAction('getGoals');

  @override
  Future<dynamic> getGoals() {
    return _$getGoalsAsyncAction.run(() => super.getGoals());
  }

  final _$getTagsAsyncAction = AsyncAction('getTags');

  @override
  Future<dynamic> getTags() {
    return _$getTagsAsyncAction.run(() => super.getTags());
  }

  final _$toggleGoalStatusAsyncAction = AsyncAction('toggleGoalStatus');

  @override
  Future<dynamic> toggleGoalStatus(GoalWithTagsAndPomodorosCount goal) {
    return _$toggleGoalStatusAsyncAction
        .run(() => super.toggleGoalStatus(goal));
  }

  final _$deleteTagAsyncAction = AsyncAction('deleteTag');

  @override
  Future<dynamic> deleteTag(TagWithPomodorosCount tag) {
    return _$deleteTagAsyncAction.run(() => super.deleteTag(tag));
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void setGoalStatus(EGoalStatus goalStatus) {
    final _$actionInfo = _$_HomeStoreActionController.startAction();
    try {
      return super.setGoalStatus(goalStatus);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPageIndex(int newIndex) {
    final _$actionInfo = _$_HomeStoreActionController.startAction();
    try {
      return super.setPageIndex(newIndex);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }
}
