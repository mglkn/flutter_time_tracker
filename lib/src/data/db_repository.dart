import 'dart:async';

import 'db.dart';
import 'dto.dart';

abstract class DbDataRepository {
  Future createGoal({String label, List<Tag> tags});
  Future<List<GoalWithTagsAndPomodorosCount>> getGoals(bool isDone);
  Future updateGoal({Goal goal, List<Tag> tags});

  Future<List<TagWithPomodorosCount>> getTags();
  Future createTag(Tag tag);

  Future createPomodoro(Goal goal);

  factory DbDataRepository.db() => _DbDataRepository();
}

class _DbDataRepository implements DbDataRepository {
  _DbDataRepository._internal();
  static final _DbDataRepository _instance = _DbDataRepository._internal();
  factory _DbDataRepository() => _instance;

  final AppDatabase _db = AppDatabase();

  @override
  Future<List<GoalWithTagsAndPomodorosCount>> getGoals(bool isDone) async {
    List<Goal> goals = await _db.goalsDao.getAll(isDone);

    final result = goals.map((Goal goal) async {
      final tags = await _db.tagsDao.getAllByGoal(goal);

      final pomodorosCount =
          await _db.pomodorosDao.getPomodorosCountByGoal(goal);

      return GoalWithTagsAndPomodorosCount(
        goal: goal,
        tags: tags,
        pomodorosCount: pomodorosCount,
      );
    });

    return Future.wait(result);
  }

  @override
  Future createPomodoro(Goal goal) {
    return _db.pomodorosDao.insert(Pomodoro(goalId: goal.id));
  }

  @override
  Future createGoal({String label, List<Tag> tags}) async {
    return _db.transaction(() async {
      final goalId = await _db.goalsDao.insert(Goal(label: label));

      _db.tagsDao.setTagsGoalsRelations(
        goalId: goalId,
        tags: tags,
      );
    });
  }

  @override
  Future createTag(Tag tag) {
    return _db.tagsDao.insert(tag);
  }

  @override
  Future<List<TagWithPomodorosCount>> getTags() {
    return _db.tagsDao.getAll();
  }

  @override
  Future updateGoal({Goal goal, List<Tag> tags}) {
    return _db.transaction(() async {
      _db.goalsDao.modify(goal);

      _db.tagsDao.setTagsGoalsRelations(goalId: goal.id, tags: tags);
    });
  }
}
