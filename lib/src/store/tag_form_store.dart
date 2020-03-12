import 'package:mobx/mobx.dart';

import 'home_store.dart';
import '../data/db_repository.dart';
import '../data/db.dart';
import '../utils/validator.dart';
import '../utils/app_localization.dart';

part 'tag_form_store.g.dart';

class TagFormStore = _TagFormStore with _$TagFormStore;

abstract class _TagFormStore with Store {
  final DbDataRepository _repo;

  final HomeStore homeStore;

  Tag tag;
  Validator validator;

  _TagFormStore({
    this.homeStore,
    DbDataRepository repo,
  })  : _repo = repo ?? DbDataRepository.db(),
        assert(homeStore != null);

  init({
    locale: AppLocalizations,
    Validator customValidator,
    Tag tag,
  }) {
    validator =
        validator ?? customValidator ?? Validator.instance(locale: locale);

    if (tag != null) {
      this.tag = tag;
      _label = tag.label;
      _color = tag.color;
      return;
    }

    _label = '';
    _color = 0xfff44336; // INITIAL RED VALUE
  }

  @observable
  String _dbError = "";

  String get dbError => _dbError;

  @observable
  String _label;

  String get label => _label;

  @action
  Future setLabel(String value) async {
    _label = value;
    await validateLabel();
  }

  @action
  Future validateLabel() async {
    if (tag != null) {
      _errorLabel = await validator.validateTagLabel(_label, tag.label);
      return;
    }
    _errorLabel = await validator.validateTagLabel(_label);
  }

  @computed
  bool get isFormValid =>
      _label != "" && (_errorLabel == null || errorLabel?.length == 0);

  @observable
  String _errorLabel;

  String get errorLabel => _errorLabel;

  @observable
  int _color;

  int get color => _color;

  @action
  void setColor(int value) => _color = value;

  Future<bool> doneEditing() async {
    if (!isFormValid) {
      validateLabel();
      return false;
    }

    var result;
    if (tag != null) {
      final changedTag = tag.copyWith(label: label, color: color);
      result = await _repo.updateTag(changedTag);
    } else {
      result = await _repo.createTag(
        Tag(label: label, color: color),
      );
    }

    result.fold(
      (error) => _dbError = error.toString(),
      (_) async {
        await homeStore.getTags();
        await homeStore.getGoals();
      },
    );

    if (_dbError.length > 0) {
      return false;
    }

    this.tag = null;

    return true;
  }
}
