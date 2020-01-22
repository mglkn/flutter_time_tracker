import 'package:flutter/material.dart';

import '../../utils/app_localization.dart';

class TagFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("createTag").toUpperCase(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('tag form'),
      ),
    );
  }
}
