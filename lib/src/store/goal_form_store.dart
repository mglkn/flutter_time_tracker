import 'package:mobx/mobx.dart';

import 'home_store.dart';
import '../data/db_repository.dart';
import '../data/dto.dart';
import '../utils/validator.dart';

part 'goal_form_store.g.dart';

class GoalFormStore = _GoalFormStore with _$GoalFormStore;

abstract class _GoalFormStore with Store {
  final DbDataRepository _repo;
  HomeStore homeStore;
  GoalWithTagsAndPomodorosCount goal;
  Validator validator;

  _GoalFormStore({
    this.homeStore,
    this.goal,
    this.validator,
    DbDataRepository repo,
  }) : _repo = repo ?? DbDataRepository.db() {
    assert(homeStore != null);
    assert(validator != null);

    _repo.getTags().then(
          (result) => result.fold(
            (error) => _dbError = error.toString(),
            (tags) {
              _setTags(tags);
            },
          ),
        );

    if (goal != null) {
      _label = goal.goal.label;
      _selectedTags = ObservableList.of(
        goal.tags.map((t) => TagWithPomodorosCount(tag: t, pomodorosCount: 0)),
      );
      return;
    }

    _label = '';
  }

  @observable
  String _dbError = "";

  String get dbError => _dbError;

  @action
  void _setTags(tags) {
    _allTags = ObservableList.of(tags);
  }

  @observable
  String _label;

  String get label => _label;

  @action
  void setLabel(String value) {
    _label = value;
    validateLabel();
  }

  @observable
  String _errorLabel;

  String get errorLabel => _errorLabel;

  @action
  void validateLabel() {
    _errorLabel = validator.validateGoalLabel(_label);
  }

  @observable
  ObservableList<TagWithPomodorosCount> _allTags =
      ObservableList<TagWithPomodorosCount>();

  List<TagWithPomodorosCount> get allTags => _allTags;

  @observable
  ObservableList<TagWithPomodorosCount> _selectedTags =
      ObservableList<TagWithPomodorosCount>();

  @computed
  List<TagWithPomodorosCount> get selectedTags => _selectedTags;

  @computed
  bool get isFormValid =>
      _label != '' && (_errorLabel == null || errorLabel?.length == 0);

  Future<bool> doneEditing() async {
    if (!isFormValid) {
      validateLabel();
      return false;
    }

    var result;
    if (goal != null) {
      final updatedGoal = goal.goal.copyWith(label: label);
      result = await _repo.updateGoal(
        goal: updatedGoal,
        tags: selectedTags.map((t) => t.tag).toList(),
      );
    } else {
      result = await _repo.createGoal(
        label: label,
        tags: selectedTags.map((t) => t.tag).toList(),
      );
    }

    result.fold(
      (error) => _dbError = error.toString(),
      (_) async {
        await homeStore.getGoals();
        await homeStore.getTags();
      },
    );

    await Future.delayed(const Duration(milliseconds: 100));

    return _dbError.length > 0 ? false : true;
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
