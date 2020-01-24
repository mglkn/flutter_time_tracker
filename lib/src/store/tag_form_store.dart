import 'package:mobx/mobx.dart';

import 'home_store.dart';
import '../data/db_repository.dart';
import '../data/db.dart';

part 'tag_form_store.g.dart';

class TagFormStore = _TagFormStore with _$TagFormStore;

abstract class _TagFormStore with Store {
  HomeStore homeStore;
  DbDataRepository repo;

  _TagFormStore({
    this.homeStore,
    this.repo,
  })  : assert(homeStore != null),
        assert(repo != null) {
    _color = 0xfff44336; // INITIAL RED VALUE
  }

  @observable
  String _label;

  String get label => _label;

  @action
  void setLabel(String value) => _label = value;

  @observable
  int _color;

  int get color => _color;

  @action
  void setColor(int value) => _color = value;

  Future createTag() async {
    final result = await repo.createTag(
      Tag(label: label, color: color),
    );

    result.fold(
      (error) => print(error.toString()),
      (_) => print('created done'),
    );

    await homeStore.getTags();
    await homeStore.getGoals();
  }
}
