import 'dart:async';
import 'package:dartz/dartz.dart';

import 'db.dart';
import 'dto.dart';

abstract class DbDataRepository {
  Future createGoal({String label, List<Tag> tags});
  Future<Either<Object, List<GoalWithTagsAndPomodorosCount>>> getGoals(
      bool isDone);
  Future<Either<Object, GoalWithTagsAndPomodorosCount>> getGoal(int goalId);
  Future<Either<Object, bool>> updateGoal({Goal goal, List<Tag> tags});

  Future<Either<Object, List<TagWithPomodorosCount>>> getTags();
  Future<Tag> getTagByLabel(String label);
  Future<Either<Object, int>> createTag(Tag tag);
  Future<Either<Object, int>> removeTag(Tag tag);
  Future<Either<Object, bool>> updateTag(Tag tag);

  Future<Either<Object, int>> createPomodoro(Goal goal);

  factory DbDataRepository.db() => _DbDataRepository();
}

class _DbDataRepository implements DbDataRepository {
  _DbDataRepository._internal();
  static final _DbDataRepository _instance = _DbDataRepository._internal();
  factory _DbDataRepository() => _instance;

  final AppDatabase _db = AppDatabase();

  @override
  Future<Either<Object, List<GoalWithTagsAndPomodorosCount>>> getGoals(
      bool isDone) {
    return Task(() async {
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
    }).attempt().run();
  }

  @override
  Future<Either<Object, GoalWithTagsAndPomodorosCount>> getGoal(
    int goalId,
  ) {
    return Task(() async {
      final goal = await _db.goalsDao.getOne(goalId);

      final tags = await _db.tagsDao.getAllByGoal(goal);

      final pomodorosCount =
          await _db.pomodorosDao.getPomodorosCountByGoal(goal);

      return GoalWithTagsAndPomodorosCount(
        goal: goal,
        tags: tags,
        pomodorosCount: pomodorosCount,
      );
    }).attempt().run();
  }

  @override
  Future<Either<Object, int>> createPomodoro(Goal goal) {
    return Task(() => _db.pomodorosDao.insert(Pomodoro(goalId: goal.id)))
        .attempt()
        .run();
  }

  @override
  Future<Either<Object, int>> createGoal({String label, List<Tag> tags}) {
    return Task(() {
      return _db.transaction(() async {
        final goalId = await _db.goalsDao.insert(Goal(label: label));

        _db.tagsDao.setTagsGoalsRelations(
          goalId: goalId,
          tags: tags,
        );

        return goalId;
      });
    }).attempt().run();
  }

  @override
  Future<Either<Object, int>> createTag(Tag tag) {
    return Task(() => _db.tagsDao.insert(tag)).attempt().run();
  }

  @override
  Future<Either<Object, List<TagWithPomodorosCount>>> getTags() {
    return Task(() => _db.tagsDao.getAll()).attempt().run();
  }

  @override
  Future<Either<Object, bool>> updateGoal({Goal goal, List<Tag> tags}) {
    return Task(
      () => _db.transaction<bool>(
        () async {
          final result = await _db.goalsDao.modify(goal);

          if (tags != null) {
            await _db.tagsDao
                .setTagsGoalsRelations(goalId: goal.id, tags: tags);
          }

          return result;
        },
      ),
    ).attempt().run();
  }

  @override
  Future<Either<Object, int>> removeTag(Tag tag) {
    return Task(() => _db.tagsDao.remove(tag)).attempt().run();
  }

  @override
  Future<Either<Object, bool>> updateTag(Tag tag) {
    return Task(() => _db.tagsDao.modify(tag)).attempt().run();
  }

  @override
  Future<Tag> getTagByLabel(String label) {
    return _db.tagsDao.getByLabel(label);
  }
}
