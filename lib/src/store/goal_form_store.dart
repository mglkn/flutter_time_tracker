import 'package:mobx/mobx.dart';

import 'home_store.dart';
import '../data/db_repository.dart';
import '../data/dto.dart';

part 'goal_form_store.g.dart';

class GoalFormStore = _GoalFormStore with _$GoalFormStore;

abstract class _GoalFormStore with Store {
  HomeStore homeStore;
  DbDataRepository repo;

  _GoalFormStore({
    this.homeStore,
    this.repo,
  })  : assert(homeStore != null),
        assert(repo != null) {
    repo.getTags().then(
          (result) => result.fold(
            (error) => print(error),
            (tags) {
              _setTags(tags);
            },
          ),
        );
  }

  @action
  void _setTags(tags) {
    _allTags = ObservableList.of(tags);
  }

  @observable
  String _label;

  String get label => _label;

  @action
  void setLabel(String value) => _label = value;

  @observable
  ObservableList<TagWithPomodorosCount> _allTags =
      ObservableList<TagWithPomodorosCount>();

  List<TagWithPomodorosCount> get allTags => _allTags;

  @observable
  ObservableList<TagWithPomodorosCount> _selectedTags =
      ObservableList<TagWithPomodorosCount>();

  List<TagWithPomodorosCount> get selectedTags => _selectedTags;

  Future createGoal() async {
    final result = await repo.createGoal(
      label: label,
      tags: selectedTags.map((t) => t.tag).toList(),
    );

    result.fold(
      (error) => print(error.toString()),
      (_) => print('created done'),
    );

    await homeStore.getGoals();
  }

  @action
  void toggleTagSelection(TagWithPomodorosCount tag) {
    if (!isTagSelected(tag)) {
      _selectedTags.add(tag);
      return;
    }

    _selectedTags = ObservableList.of(
        _selectedTags.where((t) => t.tag.id != tag.tag.id).toList());
  }

  @action
  bool isTagSelected(TagWithPomodorosCount tag) {
    var isTagSelected = false;
    for (final selectedTag in selectedTags) {
      if (selectedTag.tag.id == tag.tag.id) {
        isTagSelected = true;
        break;
      }
    }

    return isTagSelected;
  }
}
