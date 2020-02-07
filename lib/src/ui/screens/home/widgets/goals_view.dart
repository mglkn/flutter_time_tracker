import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

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
    return Container(
      child: Consumer<HomeStore>(
        builder: (_, HomeStore store, __) => Observer(
          builder: (_) => store.goals.length == 0
              ? Center(
                  child: Text(
                    AppLocalizations.of(context).translate('nogoals'),
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 26.0, color: Colors.grey[500]),
                  ),
                )
              : ListView(
                  padding: EdgeInsets.all(30.0),
                  children: store.goals.map((g) => GoalTile(g)).toList(),
                ),
        ),
      ),
    );
  }
}
