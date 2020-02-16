import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/src/utils/validator.dart';

import '../../../utils/app_localization.dart';
import '../../../store/goal_form_store.dart';
import '../../../store/home_store.dart';
import '../../../data/db_repository.dart';
import '../../../routes/router.gr.dart';
import '../../../data/dto.dart';
import 'widgets/widgets.dart';

class GoalFormScreen extends StatelessWidget {
  final GoalWithTagsAndPomodorosCount goal;

  GoalFormScreen({this.goal});

  Future _createGoalHandler(GoalFormStore goalFormStore) async {
    final shouldReturn = await goalFormStore.doneEditing();
    if (shouldReturn) AppRouter.navigator.pop();
  }

  void _focusReset(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _titleKey = goal != null ? 'editGoal' : 'createGoal';
    final title =
        AppLocalizations.of(context).translate(_titleKey).toUpperCase();

    final HomeStore homeStore = Provider.of<HomeStore>(context, listen: false);
    final goalFormStore = GoalFormStore(
      homeStore: homeStore,
      repo: DbDataRepository.db(),
      goal: goal,
      validator: Validator.instance(
        db: DbDataRepository.db(),
        locale: AppLocalizations.of(context),
      ),
    );

    return GestureDetector(
      onTap: () => _focusReset(context),
      child: Scaffold(
        appBar: AppBar(
          title: _AppBarTitle(title),
          centerTitle: true,
        ),
        body: Provider(
          create: (_) => goalFormStore,
          child: GoalForm(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () => _createGoalHandler(goalFormStore),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  final String title;

  _AppBarTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6.copyWith(
            letterSpacing: 10.0,
          ),
    );
  }
}
