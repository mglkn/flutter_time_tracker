import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart';

import '../data/db.dart';
import '../data/db_repository.dart';

part 'goal_store.g.dart';

class GoalStore = _GoalStore with _$GoalStore;

abstract class _GoalStore with Store {
  Goal _goal;
  DbDataRepository _db;

  _GoalStore({
    @required Goal goal,
    @required DbDataRepository db,
  }) {
    assert(goal != null);
    assert(db != null);

    _goal = goal;
    _db = db;

    _db.getPomodorosByGoal(goal).then(
          (result) => result.fold(
            (error) => print(error.toString()),
            _setPomodoros,
          ),
        );
  }

  @action
  void _setPomodoros(List<Pomodoro> pomodoros) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _todayPomodorosCount = pomodoros.where((p) {
      return p.date.isAfter(today);
    }).length;

    _allPomodorosCount = pomodoros.length;
  }

  String get label => _goal.label;

  @observable
  int _todayPomodorosCount;

  int get todayPomodorosCount => _todayPomodorosCount;

  @observable
  int _allPomodorosCount;

  int get allPomodorosCount => _allPomodorosCount;

  @action
  Future addPomodoro() async {
    (await _db.createPomodoro(_goal))
        .fold((error) => print(error), (_) => print('pomodoro created'));
  }
}
