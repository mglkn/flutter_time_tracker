import 'package:mobx/mobx.dart';

import '../data/dto.dart';
import '../data/db_repository.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

enum EGoalStatus {
  DONE,
  ONGOING,
}

abstract class _HomeStore with Store {
  final DbDataRepository _repo;

  _HomeStore({DbDataRepository repo}) : _repo = repo ?? DbDataRepository.db() {
    getGoals();
    getTags();
  }

  @observable
  ObservableList<GoalWithTagsAndPomodorosCount> _goals =
      ObservableList<GoalWithTagsAndPomodorosCount>();

  List<GoalWithTagsAndPomodorosCount> get goals => _goals;

  @observable
  ObservableList<TagWithPomodorosCount> _tags =
      ObservableList<TagWithPomodorosCount>();

  List<TagWithPomodorosCount> get tags => _tags;

  @observable
  EGoalStatus _goalStatus = EGoalStatus.ONGOING;

  bool get isGoalDone => _goalStatus == EGoalStatus.DONE;

  @action
  void setGoalStatus(EGoalStatus goalStatus) {
    if (goalStatus == _goalStatus) return;
    _goalStatus = goalStatus;
    getGoals();
  }

  @observable
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  @action
  void setPageIndex(int newIndex) => _pageIndex = newIndex;

  @observable
  String _dbError = "";

  String get dbError => _dbError;

  @action
  Future getGoals() async {
    final result = await _repo.getGoals(isGoalDone);

    result.fold(
      (error) => _dbError = error.toString(),
      (goals) => _goals = ObservableList.of(goals),
    );
  }

  @action
  Future getTags() async {
    final result = await _repo.getTags();

    result.fold(
      (error) => _dbError = error.toString(),
      (tags) => _tags = ObservableList.of(tags),
    );
  }

  @action
  Future toggleGoalStatus(GoalWithTagsAndPomodorosCount goal) async {
    final updatedGoal = goal.goal.copyWith(isDone: !goal.goal.isDone);
    await _repo.updateGoal(goal: updatedGoal, tags: null);
    await getGoals();
  }

  @action
  Future deleteTag(TagWithPomodorosCount tag) async {
    await _repo.removeTag(tag.tag);
    await getTags();
    await getGoals();
  }
}
