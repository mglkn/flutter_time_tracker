import 'dart:async';

import 'db.dart';
import 'dto.dart';

abstract class DbDataRepository {
  Future<List<GoalWithTagsAndPomodorosCount>> getGoals(bool isDone);

  factory DbDataRepository.db() => _DbDataRepository();
}

class _DbDataRepository implements DbDataRepository {
  _DbDataRepository._internal();
  static final _DbDataRepository _instance = _DbDataRepository._internal();
  factory _DbDataRepository() => _instance;

  final AppDatabase _db = AppDatabase();

  @override
  Future<List<GoalWithTagsAndPomodorosCount>> getGoals(bool isDone) async {
    List<Goal> goals = await _db.goalsDao.watchGoals(isDone);

    return goals
        .map<GoalWithTagsAndPomodorosCount>(
            (Goal goal) => GoalWithTagsAndPomodorosCount(goal: goal))
        .toList();
  }
}
