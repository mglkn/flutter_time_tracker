import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../utils/app_localization.dart';
import '../../../store/goal_form_store.dart';
import '../../../data/dto.dart';
import 'widgets/widgets.dart';

class GoalFormScreen extends StatefulWidget {
  final GoalWithTagsAndPomodorosCount goal;

  GoalFormScreen({this.goal});

  @override
  _GoalFormScreenState createState() => _GoalFormScreenState();
}

class _GoalFormScreenState extends State<GoalFormScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Modular.get<GoalFormStore>().init(locale: AppLocalizations.of(context));
  }

  Future _doneGoalHandler() async {
    final GoalFormStore goalFormStore = Modular.get<GoalFormStore>();
    final shouldReturn = await goalFormStore.doneEditing();
    if (shouldReturn) Modular.to.pop();
  }

  void _focusReset(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _titleKey = widget.goal != null ? 'editGoal' : 'createGoal';
    final title =
        AppLocalizations.of(context).translate(_titleKey).toUpperCase();

    // final goalFormStore = GoalFormStore(
    //   homeStore: homeStore,
    //   goal: goal,
    //   validator: Validator.instance(
    //     db: DbDataRepository.db(),
    //     locale: AppLocalizations.of(context),
    //   ),
    // );

    return GestureDetector(
      onTap: () => _focusReset(context),
      child: Scaffold(
        appBar: AppBar(
          title: _AppBarTitle(title),
          centerTitle: true,
        ),
        body: GoalForm(),
        // body: Provider(
        //   create: (_) => goalFormStore,
        //   child: GoalForm(),
        // ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () => _doneGoalHandler(),
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
