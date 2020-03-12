import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:time_tracker/src/data/db_repository.dart';
import 'package:time_tracker/src/data/dto.dart';
import 'package:time_tracker/src/data/db.dart';

class DBDataRepositoryMock extends Mock implements DbDataRepository {}

DBDataRepositoryMock getDBRepoWithGoalsAndTagsMocked({
  List<GoalWithTagsAndPomodorosCount> goals,
  List<TagWithPomodorosCount> tags,
}) {
  final repo = DBDataRepositoryMock();

  when(repo.getGoals(false)).thenAnswer((_) {
    return Task(() {
      return Future.value(goals ?? <GoalWithTagsAndPomodorosCount>[]);
    }).attempt().run();
  });

  when(repo.getGoals(true)).thenAnswer((_) {
    return Task(() {
      return Future.value(goals ?? <GoalWithTagsAndPomodorosCount>[]);
    }).attempt().run();
  });

  when(repo.getTags()).thenAnswer((_) {
    return Task(() {
      return Future.value(tags ?? <TagWithPomodorosCount>[]);
    }).attempt().run();
  });

  return repo;
}

DBDataRepositoryMock setDBDataMockToErrorInGetGoals(
    {DBDataRepositoryMock repo, String error}) {
  when(repo.getGoals(false)).thenAnswer((_) {
    return Task(() async {
      throw Exception(error);
    }).attempt().run();
  });
  return repo;
}

DBDataRepositoryMock setDBDataMockToErrorInGetTags(
    {DBDataRepositoryMock repo, String error}) {
  when(repo.getTags()).thenAnswer((_) {
    return Task(() async {
      throw Exception(error);
    }).attempt().run();
  });

  return repo;
}

DBDataRepositoryMock setDbDataMovkToRemoveTag(
    {DBDataRepositoryMock repo, Tag tag}) {
  when(repo.removeTag(tag)).thenAnswer((_) {
    return Task(() {
      return Future.value(1);
    }).attempt().run();
  });

  return repo;
}
