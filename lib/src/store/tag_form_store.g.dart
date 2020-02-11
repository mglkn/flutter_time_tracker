// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TagFormStore on _TagFormStore, Store {
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid)).value;

  final _$_dbErrorAtom = Atom(name: '_TagFormStore._dbError');

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

  final _$_labelAtom = Atom(name: '_TagFormStore._label');

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

  final _$_errorLabelAtom = Atom(name: '_TagFormStore._errorLabel');

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

  final _$_colorAtom = Atom(name: '_TagFormStore._color');

  @override
  int get _color {
    _$_colorAtom.context.enforceReadPolicy(_$_colorAtom);
    _$_colorAtom.reportObserved();
    return super._color;
  }

  @override
  set _color(int value) {
    _$_colorAtom.context.conditionallyRunInAction(() {
      super._color = value;
      _$_colorAtom.reportChanged();
    }, _$_colorAtom, name: '${_$_colorAtom.name}_set');
  }

  final _$setLabelAsyncAction = AsyncAction('setLabel');

  @override
  Future<dynamic> setLabel(String value) {
    return _$setLabelAsyncAction.run(() => super.setLabel(value));
  }

  final _$validateLabelAsyncAction = AsyncAction('validateLabel');

  @override
  Future<dynamic> validateLabel() {
    return _$validateLabelAsyncAction.run(() => super.validateLabel());
  }

  final _$_TagFormStoreActionController =
      ActionController(name: '_TagFormStore');

  @override
  void setColor(int value) {
    final _$actionInfo = _$_TagFormStoreActionController.startAction();
    try {
      return super.setColor(value);
    } finally {
      _$_TagFormStoreActionController.endAction(_$actionInfo);
    }
  }
}
