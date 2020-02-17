import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../data/dto.dart';
import '../../../data/db_repository.dart';
import '../../../store/goal_store.dart';
import '../../../utils/app_localization.dart';
import 'widgets/widgets.dart';

class GoalScreen extends StatelessWidget {
  final GoalWithTagsAndPomodorosCount goal;

  GoalScreen({@required this.goal}) : assert(goal != null);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => GoalStore(
        goal: goal.goal,
      ),
      child: _EscapePreventerWrapper(
        child: _GoalScreen(),
      ),
    );
  }
}

class _GoalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalStore store, __) => Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: 'goal_title_${store.label}',
            child: Text(
              store.label,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: 20.0,
                  ),
            ),
          ),
          centerTitle: true,
        ),
        body: Observer(builder: (_) {
          if (store.dbError.length > 0) {
            return Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate('dbError'),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Text(store.dbError),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                PomodorosDisplay(),
                const SizedBox(height: 50.0),
                Timer(),
                const SizedBox(height: 20.0),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _EscapePreventerWrapper extends StatelessWidget {
  final Widget child;

  _EscapePreventerWrapper({
    @required this.child,
  }) : assert(child != null);

  Future<bool> _onWillPop(BuildContext context) {
    GoalStore store = Provider.of<GoalStore>(context, listen: false);

    if (store.timerState != ETimerState.READY) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(
            AppLocalizations.of(context).translate('escapeGoalTitle'),
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 30.0,
                ),
          ),
          content: Text(
            AppLocalizations.of(context).translate('escapeGoalContent'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                AppLocalizations.of(context).translate('yes').toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 20.0,
                    ),
              ),
              onPressed: () {
                store.cleanTimer();
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text(
                AppLocalizations.of(context).translate('no').toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 20.0,
                    ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      );
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: child,
    );
  }
}
