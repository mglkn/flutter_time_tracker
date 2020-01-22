import 'package:mobx/mobx.dart';

import '../data/dto.dart';
import '../data/db_repository.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final DbDataRepository _repo;

  _HomeStore({DbDataRepository repo})
      : _repo = repo,
        assert(repo != null) {
    _getGoals();
    _getTags();
  }

  @observable
  ObservableList<GoalWithTagsAndPomodorosCount> _goals =
      ObservableList<GoalWithTagsAndPomodorosCount>();

  List<GoalWithTagsAndPomodorosCount> get goals => _goals.toList();

  @observable
  ObservableList<TagWithPomodorosCount> _tags =
      ObservableList<TagWithPomodorosCount>();

  List<TagWithPomodorosCount> get tags => _tags.toList();

  @observable
  bool isGoalDoneFlag = false;

  @action
  void toggleGoalDoneFlag() => isGoalDoneFlag != isGoalDoneFlag;

  @action
  Future _getGoals() async {
    final result = await _repo.getGoals(isGoalDoneFlag);

    // TODO: error handle
    result.fold(
      (error) => print(error),
      (goals) => _goals = ObservableList.of(goals),
    );
  }

  @action
  Future _getTags() async {
    final result = await _repo.getTags();

    // TODO: error handle
    result.fold(
      (error) => print(error),
      (tags) => _tags = ObservableList.of(tags),
    );
  }

  @action
  Future toggleGoalStatus(GoalWithTagsAndPomodorosCount goal) async {
    final updatedGoal = goal.goal.copyWith(isDone: !goal.goal.isDone);
    await _repo.updateGoal(goal: updatedGoal, tags: null);
    await _getGoals();
  }
}
