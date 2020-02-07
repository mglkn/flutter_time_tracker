import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../store/home_store.dart';
import '../../../../utils/app_localization.dart';
import 'tag_tile.dart';

class TagsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<HomeStore>(
        builder: (_, HomeStore store, __) => Observer(
          builder: (_) => store.tags.length == 0
              ? Center(
                  child: Text(
                    AppLocalizations.of(context).translate('notags'),
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 26.0, color: Colors.grey[500]),
                  ),
                )
              : ListView(
                  padding: EdgeInsets.all(30.0),
                  children: store.tags.map((t) => TagTile(t)).toList(),
                ),
        ),
      ),
    );
  }
}
