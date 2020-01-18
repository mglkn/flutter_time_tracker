import 'package:moor_flutter/moor_flutter.dart';

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

@UseDao(tables: [Goals])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  GoalsDao(AppDatabase db) : super(db);

  Future<int> insertGoal(Goal goal) => into(goals).insert(goal);
  Future<List<Goal>> watchGoals(bool isDone) => (select(goals)
      // ..where(goals.isDone.equals(isDone))
      )
      .get();
}

@UseDao(tables: [Tags])
class TagsDao extends DatabaseAccessor<AppDatabase> with _$TagsDaoMixin {
  TagsDao(AppDatabase db) : super(db);

  Future insertTag(Tag tag) => into(tags).insert(tag);
  Future updateTag(Tag tag) => update(tags).replace(tag);
}

@UseDao(tables: [Pomodoros])
class PomodorosDao extends DatabaseAccessor<AppDatabase>
    with _$PomodorosDaoMixin {
  PomodorosDao(AppDatabase db) : super(db);

  Future insertPomodoro(Pomodoro pomodoro) => into(pomodoros).insert(pomodoro);
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
