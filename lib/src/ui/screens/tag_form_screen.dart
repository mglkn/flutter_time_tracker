import 'package:flutter/material.dart';

import '../../utils/app_localization.dart';
import '../widgets/forms/forms.dart';

class TagFormScreen extends StatelessWidget {
  _createTagHandler() {
    print('create tag handler');
  }

  @override
  Widget build(BuildContext context) {
    final title =
        AppLocalizations.of(context).translate("createTag").toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: TagForm(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: _createTagHandler,
      ),
    );
  }
}
