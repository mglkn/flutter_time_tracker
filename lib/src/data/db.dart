import 'package:moor_flutter/moor_flutter.dart';

part 'db.g.dart';

class Goals extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  BoolColumn get isDone => boolean().nullable().withDefault(Constant(false))();
  DateTimeColumn get date =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();
  TextColumn get label => text().withLength(min: 1, max: 100)();

  // @override
  // Set<Column> get primaryKey => {id};
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

@UseMoor(
  tables: [Goals],
  daos: [GoalsDao],
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
