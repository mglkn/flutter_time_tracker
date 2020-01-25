import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/src/utils/validator.dart';

import '../../utils/app_localization.dart';
import '../widgets/forms/forms.dart';
import '../../store/goal_form_store.dart';
import '../../store/home_store.dart';
import '../../data/db_repository.dart';
import '../../routes/router.gr.dart';
import '../../data/dto.dart';

class GoalFormScreen extends StatelessWidget {
  final GoalWithTagsAndPomodorosCount goal;

  GoalFormScreen({this.goal});

  Future _createGoalHandler(GoalFormStore goalFormStore) async {
    final shouldReturn = await goalFormStore.doneEditing();
    if (shouldReturn) AppRouter.navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final title =
        AppLocalizations.of(context).translate("createGoal").toUpperCase();

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

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
    );
  }
}
