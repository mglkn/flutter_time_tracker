import 'package:flutter/material.dart';

import 'color_picker.dart';
import 'input_tag_label.dart';

class TagForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .9,
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InputTagLabel(),
              const SizedBox(height: 20.0),
              Expanded(child: ColorPicker()),
            ],
          ),
        ),
      ),
    );
  }
}
