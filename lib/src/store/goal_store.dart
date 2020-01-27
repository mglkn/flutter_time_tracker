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
  })  : _goal = goal,
        _db = db,
        assert(goal != null),
        assert(db != null);

  String get label => _goal.label;
}
