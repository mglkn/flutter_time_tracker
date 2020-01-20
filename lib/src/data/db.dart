import 'dart:async';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:time_tracker/src/data/dto.dart';

part 'db.g.dart';

class Goals extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  BoolColumn get isDone => boolean().nullable().withDefault(Constant(false))();
  DateTimeColumn get date =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();
  TextColumn get label => text().withLength(min: 1, max: 100)();
}

class Tags extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get label => text().withLength(min: 1, max: 100)();
  DateTimeColumn get date =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();
  IntColumn get color => integer()();
}

class TagsGoals extends Table {
  IntColumn get goalId => integer().customConstraint("REFERENCES goals(id)")();
  IntColumn get tagId => integer().customConstraint("REFERENCES tags(id)")();

  @override
  Set<Column> get primaryKey => {goalId, tagId};
}

class Pomodoros extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  DateTimeColumn get date =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();
  IntColumn get goalId => integer().customConstraint("REFERENCES goals(id)")();

  @override
  Set<Column> get primaryKey => {id, goalId};
}

@UseDao(tables: [Goals, Tags, TagsGoals, Pomodoros])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  GoalsDao(AppDatabase db) : super(db);

  Future<List<Goal>> getAll(bool isDone) => (select(goals)
        ..where((t) => t.isDone.equals(isDone))
        ..orderBy(
          ([
            (t) => OrderingTerm(
                  expression: t.date,
                  mode: OrderingMode.desc,
                )
          ]),
        ))
      .get();

  Future<Goal> getOne(int goalId) =>
      (select(goals)..where((t) => t.id.equals(goalId))).getSingle();

  Future<Goal> getOneById(int goalId) =>
      (select(goals)..where((t) => t.id.equals(goalId))).getSingle();

  Future<int> insert(Goal goal) => into(goals).insert(goal);
  Future<bool> modify(Goal goal) => update(goals).replace(goal);
}

@UseDao(tables: [Tags, TagsGoals])
class TagsDao extends DatabaseAccessor<AppDatabase> with _$TagsDaoMixin {
  TagsDao(AppDatabase db) : super(db);

  Future<List<TagWithPomodorosCount>> getAll() async {
    final queryRow = await customSelectQuery("""
        SELECT 
          (tags.id) as id, tags.label as label, tags.color AS color, tags.date AS date,  COUNT(tags.id) as count_pomodoros
        FROM pomodoros 
        JOIN tags_goals ON tags_goals.goal_id == pomodoros.goal_id
        JOIN tags ON tags.id == tags_goals.tag_id
        GROUP BY tags.id
        ORDER BY tags.id DESC;
      """).get();

    return queryRow
        .map(
          (qr) => TagWithPomodorosCount(
            tag: Tag.fromData(qr.data, db),
            pomodorosCount: qr.readInt('count_pomodoros'),
          ),
        )
        .toList();
  }

  Future<List<Tag>> getAllByGoal(Goal goal) async {
    final result = await (select(tagsGoals).join(
      [
        innerJoin(
          tags,
          tags.id.equalsExp(tagsGoals.tagId),
        ),
      ],
    )..where(tagsGoals.goalId.equals(goal.id)))
        .get();

    return result.map((TypedResult tr) => tr.readTable(tags)).toList();
  }

  Future<int> insert(Tag tag) => into(tags).insert(tag);
  Future<bool> modify(Tag tag) => update(tags).replace(tag);
  Future<int> remove(Tag tag) {
    return transaction<int>(() async {
      await (delete(tags)..where((t) => t.id.equals(tag.id))).go();
      await (delete(tagsGoals)..where((t) => t.tagId.equals(tag.id))).go();
      return tag.id;
    });
  }

  Future setTagsGoalsRelations({int goalId, List<Tag> tags}) {
    return transaction(() async {
      await (delete(tagsGoals)..where((t) => t.goalId.equals(goalId))).go();
      for (var tag in tags) {
        await into(tagsGoals).insert(TagsGoal(
          goalId: goalId,
          tagId: tag.id,
        ));
      }
    });
  }
}

@UseDao(tables: [Pomodoros])
class PomodorosDao extends DatabaseAccessor<AppDatabase>
    with _$PomodorosDaoMixin {
  PomodorosDao(AppDatabase db) : super(db);

  Future<int> getPomodorosCountByGoal(Goal goal) async {
    final queryRow = await customSelectQuery(
      'SELECT COUNT(*) as count FROM pomodoros WHERE goal_id = ?',
      variables: [Variable.withInt(goal.id)],
    ).getSingle();

    return queryRow.readInt('count');
  }

  Future insert(Pomodoro pomodoro) => into(pomodoros).insert(pomodoro);
}

@UseMoor(
  tables: [Goals, Tags, Pomodoros, TagsGoals],
  daos: [GoalsDao, TagsDao, PomodorosDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
            // logStatements: true,
          ),
        );

  @override
  int get schemaVersion => 1;
}
