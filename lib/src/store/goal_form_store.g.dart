// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GoalFormStore on _GoalFormStore, Store {
  Computed<List<TagWithPomodorosCount>> _$selectedTagsComputed;

  @override
  List<TagWithPomodorosCount> get selectedTags => (_$selectedTagsComputed ??=
          Computed<List<TagWithPomodorosCount>>(() => super.selectedTags))
      .value;
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid)).value;

  final _$_dbErrorAtom = Atom(name: '_GoalFormStore._dbError');

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

  final _$_labelAtom = Atom(name: '_GoalFormStore._label');

  @override
  String get _label {
    _$_labelAtom.context.enforceReadPolicy(_$_labelAtom);
    _$_labelAtom.reportObserved();
    return super._label;
  }

  @override
  set _label(String value) {
    _$_labelAtom.context.conditionallyRunInAction(() {
      super._label = value;
      _$_labelAtom.reportChanged();
    }, _$_labelAtom, name: '${_$_labelAtom.name}_set');
  }

  final _$_errorLabelAtom = Atom(name: '_GoalFormStore._errorLabel');

  @override
  String get _errorLabel {
    _$_errorLabelAtom.context.enforceReadPolicy(_$_errorLabelAtom);
    _$_errorLabelAtom.reportObserved();
    return super._errorLabel;
  }

  @override
  set _errorLabel(String value) {
    _$_errorLabelAtom.context.conditionallyRunInAction(() {
      super._errorLabel = value;
      _$_errorLabelAtom.reportChanged();
    }, _$_errorLabelAtom, name: '${_$_errorLabelAtom.name}_set');
  }

  final _$_allTagsAtom = Atom(name: '_GoalFormStore._allTags');

  @override
  ObservableList<TagWithPomodorosCount> get _allTags {
    _$_allTagsAtom.context.enforceReadPolicy(_$_allTagsAtom);
    _$_allTagsAtom.reportObserved();
    return super._allTags;
  }

  @override
  set _allTags(ObservableList<TagWithPomodorosCount> value) {
    _$_allTagsAtom.context.conditionallyRunInAction(() {
      super._allTags = value;
      _$_allTagsAtom.reportChanged();
    }, _$_allTagsAtom, name: '${_$_allTagsAtom.name}_set');
  }

  final _$_selectedTagsAtom = Atom(name: '_GoalFormStore._selectedTags');

  @override
  ObservableList<TagWithPomodorosCount> get _selectedTags {
    _$_selectedTagsAtom.context.enforceReadPolicy(_$_selectedTagsAtom);
    _$_selectedTagsAtom.reportObserved();
    return super._selectedTags;
  }

  @override
  set _selectedTags(ObservableList<TagWithPomodorosCount> value) {
    _$_selectedTagsAtom.context.conditionallyRunInAction(() {
      super._selectedTags = value;
      _$_selectedTagsAtom.reportChanged();
    }, _$_selectedTagsAtom, name: '${_$_selectedTagsAtom.name}_set');
  }

  final _$_GoalFormStoreActionController =
      ActionController(name: '_GoalFormStore');

  @override
  void _setTags(dynamic tags) {
    final _$actionInfo = _$_GoalFormStoreActionController.startAction();
    try {
      return super._setTags(tags);
    } finally {
      _$_GoalFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLabel(String value) {
    final _$actionInfo = _$_GoalFormStoreActionController.startAction();
    try {
      return super.setLabel(value);
    } finally {
      _$_GoalFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateLabel() {
    final _$actionInfo = _$_GoalFormStoreActionController.startAction();
    try {
      return super.validateLabel();
    } finally {
      _$_GoalFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTagSelection(TagWithPomodorosCount tag) {
    final _$actionInfo = _$_GoalFormStoreActionController.startAction();
    try {
      return super.toggleTagSelection(tag);
    } finally {
      _$_GoalFormStoreActionController.endAction(_$actionInfo);
    }
  }
}
