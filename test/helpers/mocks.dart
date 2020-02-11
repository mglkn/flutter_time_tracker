import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:time_tracker/src/data/db_repository.dart';
import 'package:time_tracker/src/data/dto.dart';

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
