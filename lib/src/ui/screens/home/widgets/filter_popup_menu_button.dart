import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../store/home_store.dart';
import '../../../../utils/app_localization.dart';

class FilterPopupMenuButton extends StatelessWidget {
  String _getStatusLabel(EGoalStatus status) {
    return status.toString().split('.').last.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final choices = <EGoalStatus>[EGoalStatus.DONE, EGoalStatus.ONGOING];
    final store = Modular.get<HomeStore>();
    return Observer(
      builder: (_) => store.pageIndex > 0
          ? SizedBox(width: 50.0)
          : PopupMenuButton<EGoalStatus>(
              onSelected: store.setGoalStatus,
              icon: Icon(Icons.filter_list),
              elevation: 2.0,
              itemBuilder: (_) => choices
                  .map(
                    (EGoalStatus choice) => PopupMenuItem<EGoalStatus>(
                      child: Text(
                        AppLocalizations.of(context)
                            .translate(_getStatusLabel(choice))
                            .toUpperCase(),
                      ),
                      value: choice,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
