import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../../store/home_store.dart';
import '../../../../utils/app_localization.dart';

class FilterPopupMenuButton extends StatelessWidget {
  String _getStatusLabel(EGoalStatus status) {
    return status.toString().split('.').last.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final choices = <EGoalStatus>[EGoalStatus.DONE, EGoalStatus.ONGOING];
    return Consumer(
      builder: (_, HomeStore store, __) => Observer(
        builder: (_) => store.pageIndex > 0
            ? Container()
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
      ),
    );
  }
}
