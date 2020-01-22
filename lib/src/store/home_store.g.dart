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

  final _$isGoalDoneFlagAtom = Atom(name: '_HomeStore.isGoalDoneFlag');

  @override
  bool get isGoalDoneFlag {
    _$isGoalDoneFlagAtom.context.enforceReadPolicy(_$isGoalDoneFlagAtom);
    _$isGoalDoneFlagAtom.reportObserved();
    return super.isGoalDoneFlag;
  }

  @override
  set isGoalDoneFlag(bool value) {
    _$isGoalDoneFlagAtom.context.conditionallyRunInAction(() {
      super.isGoalDoneFlag = value;
      _$isGoalDoneFlagAtom.reportChanged();
    }, _$isGoalDoneFlagAtom, name: '${_$isGoalDoneFlagAtom.name}_set');
  }

  final _$_getGoalsAsyncAction = AsyncAction('_getGoals');

  @override
  Future<dynamic> _getGoals() {
    return _$_getGoalsAsyncAction.run(() => super._getGoals());
  }

  final _$_getTagsAsyncAction = AsyncAction('_getTags');

  @override
  Future<dynamic> _getTags() {
    return _$_getTagsAsyncAction.run(() => super._getTags());
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
  void toggleGoalDoneFlag() {
    final _$actionInfo = _$_HomeStoreActionController.startAction();
    try {
      return super.toggleGoalDoneFlag();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }
}
