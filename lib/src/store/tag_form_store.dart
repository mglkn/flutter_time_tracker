import 'package:mobx/mobx.dart';

import 'home_store.dart';
import '../data/db_repository.dart';
import '../data/db.dart';
import '../utils/validator.dart';

part 'tag_form_store.g.dart';

class TagFormStore = _TagFormStore with _$TagFormStore;

abstract class _TagFormStore with Store {
  HomeStore homeStore;
  DbDataRepository repo;
  Tag tag;
  Validator validator;

  _TagFormStore({
    this.homeStore,
    this.repo,
    this.tag,
    this.validator,
  })  : assert(homeStore != null),
        assert(repo != null),
        assert(validator != null) {
    if (tag != null) {
      _label = tag.label;
      _color = tag.color;
      return;
    }
    _label = '';
    _color = 0xfff44336; // INITIAL RED VALUE
  }

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
      result = await repo.updateTag(changedTag);
    } else {
      result = await repo.createTag(
        Tag(label: label, color: color),
      );
    }

    result.fold(
      (error) => print(error.toString()),
      (_) => print('created done'),
    );

    await homeStore.getTags();
    await homeStore.getGoals();

    return true;
  }
}
