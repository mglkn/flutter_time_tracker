import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

import 'package:time_tracker/src/ui/screens/home/home_screen.dart';
import 'package:time_tracker/src/store/home_store.dart';
import 'package:time_tracker/src/utils/constants.dart';
import 'package:time_tracker/src/data/dto.dart';
import 'package:time_tracker/src/data/db.dart';

import './home_screen_helpers.dart';
import '../helpers/mocks.dart';

main() {
  testWidgets('HomeScreen should show appBar title',
      (WidgetTester tester) async {
    final repo = getDBRepoWithGoalsAndTagsMocked();
    final homeStore = HomeStore(repo: repo);

    final homeScreen = Provider<HomeStore>(
      create: (_) => homeStore,
      child: HomeScreen(),
    );

    await tester.pumpWidget(await wrapMaterialApp(homeScreen));
    await tester.pump();

    final titleGoals = find.byKey(Key(Constants.titleGoals));
    final titleTags = find.byKey(Key(Constants.titleTags));

    expect(titleGoals, findsNWidgets(1));
    expect(titleTags, findsNWidgets(1));
  }, skip: false);

  testWidgets('HomeScreen should show goals', (WidgetTester tester) async {
    final goal = GoalWithTagsAndPomodorosCount(
      goal: Goal(
        id: 0,
        label: 'goal_title',
        isDone: false,
        date: DateTime.now(),
      ),
      tags: [],
      pomodorosCount: 0,
    );

    final goals = [goal];

    final repo = getDBRepoWithGoalsAndTagsMocked(goals: goals);

    final homeStore = HomeStore(repo: repo);

    final homeScreen = Provider<HomeStore>(
      create: (_) => homeStore,
      child: HomeScreen(),
    );

    await tester.pumpWidget(await wrapMaterialApp(homeScreen));
    await tester.pump();

    final goalTileTitle = find.text('goal_title');

    verify(repo.getGoals(false)).called(1);
    expect(goalTileTitle, findsOneWidget);
  });
}
