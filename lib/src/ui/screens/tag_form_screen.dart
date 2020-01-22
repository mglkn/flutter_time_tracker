import 'package:flutter/material.dart';

import '../../utils/app_localization.dart';
import '../widgets/forms/forms.dart';

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
      body: TagForm(),
    );
  }
}
