import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:time_tracker/src/store/home_store.dart';
import 'package:time_tracker/src/data/db_repository.dart';
import 'package:time_tracker/src/data/dto.dart';
import 'package:time_tracker/src/data/db.dart';

import '../helpers/mocks.dart';

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
    verify(repo.getGoals(false)).called(1);
    verify(repo.getTags()).called(1);
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
    verify(repo.getGoals(false)).called(1);
    verify(repo.getGoals(true)).called(1);
  });

  test('initial page index should equal 0', () {
    final repo = getDBRepoWithGoalsAndTagsMocked();
    final homeStore = HomeStore(repo: repo);

    expect(homeStore.pageIndex, 0);
  });

  test('set page index should change it', () {
    final repo = getDBRepoWithGoalsAndTagsMocked();
    final homeStore = HomeStore(repo: repo);

    homeStore.setPageIndex(1);

    expect(homeStore.pageIndex, 1);
  });

  test('dbError should change if error occured into getGoals', () async {
    final errorMessage = 'db error';
    final repo = setDBDataMockToErrorInGetGoals(
        repo: getDBRepoWithGoalsAndTagsMocked(), error: errorMessage);

    final homeStore = HomeStore(repo: repo);

    await Future.delayed(const Duration(milliseconds: 100));

    expect(homeStore.dbError, 'Exception: $errorMessage');
  });

  test('dbError should change if error occured into getTags', () async {
    final errorMessage = 'db error';
    final repo = setDBDataMockToErrorInGetTags(
        repo: getDBRepoWithGoalsAndTagsMocked(), error: errorMessage);

    final homeStore = HomeStore(repo: repo);

    await Future.delayed(const Duration(milliseconds: 100));

    expect(homeStore.dbError, 'Exception: $errorMessage');
  });

  test('remove tag should call removeTag, getGoals and getTags', () async {
    final tag = TagWithPomodorosCount(
      tag: Tag(label: 'tag1', color: 0xFF000000),
      pomodorosCount: 0,
    );

    final tags = [tag];

    final repo = setDbDataMovkToRemoveTag(
      repo: getDBRepoWithGoalsAndTagsMocked(tags: tags),
      tag: tag.tag,
    );

    final homeStore = HomeStore(repo: repo);

    await Future.delayed(const Duration(milliseconds: 100));

    await homeStore.deleteTag(tag);

    verify(repo.removeTag(tag.tag)).called(1);
    verify(repo.getGoals(false)).called(2);
    verify(repo.getTags()).called(2);
  });
}
