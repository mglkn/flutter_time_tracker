import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../store/home_store.dart';
import '../../../../utils/app_localization.dart';
import 'goal_tile.dart';

class GoalsView extends StatefulWidget {
  @override
  _GoalsViewState createState() => _GoalsViewState();
}

class _GoalsViewState extends State<GoalsView> {
  @override
  Widget build(BuildContext context) {
    final HomeStore store = Modular.get<HomeStore>();
    return Observer(builder: (_) {
      if (store.dbError.length > 0) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('dbError'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(store.dbError),
          ],
        );
      }

      if (store.goals.length == 0) {
        return Center(
          child: Text(
            AppLocalizations.of(context).translate('nogoals'),
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(fontSize: 26.0, color: Colors.grey[500]),
          ),
        );
      }

      return ListView(
        padding: EdgeInsets.all(30.0),
        children: store.goals.map((g) => GoalTile(g)).toList(),
      );
    });
  }
}
