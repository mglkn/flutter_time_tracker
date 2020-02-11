import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:time_tracker/src/store/home_store.dart';
import 'package:time_tracker/src/data/db_repository.dart';
import 'package:time_tracker/src/data/dto.dart';

import '../helpers/mocks.dart';

class DBDataRepositoryMock extends Mock implements DbDataRepository {}

void main() {
  test('init store should get goals and tags', () async {
    final goals = <GoalWithTagsAndPomodorosCount>[
      GoalWithTagsAndPomodorosCount(
        goal: null,
        pomodorosCount: 0,
        tags: [],
      )
    ];
    final tags = <TagWithPomodorosCount>[];

    final repo = getDBRepoWithGoalsAndTagsMocked(goals: goals, tags: tags);
    final homeStore = HomeStore(repo: repo);

    await Future.delayed(const Duration(milliseconds: 100));

    expect(homeStore.goals.length, goals.length);
    expect(homeStore.tags.length, tags.length);
  });

  test('initial goal done status should \'false\'', () {
    final repo = getDBRepoWithGoalsAndTagsMocked();
    final homeStore = HomeStore(repo: repo);

    expect(homeStore.isGoalDone, false);
  });

  test('change goal status should be changed', () async {
    final repo = getDBRepoWithGoalsAndTagsMocked();
    final homeStore = HomeStore(repo: repo);

    homeStore.setGoalStatus(EGoalStatus.DONE);

    expect(homeStore.isGoalDone, true);
  });
}
