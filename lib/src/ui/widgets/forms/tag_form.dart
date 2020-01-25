import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/app_localization.dart';
import '../../../store/tag_form_store.dart';

class TagForm extends StatelessWidget {
  void _focusReset(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _focusReset(context),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * .9,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _InputTextField(),
                const SizedBox(height: 20.0),
                Expanded(child: _ColorPicker()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hintText = AppLocalizations.of(context).translate('enterTag');

    return Consumer(
      builder: (_, TagFormStore store, __) => Observer(
        builder: (_) => TextFormField(
          initialValue: store.label,
          onChanged: store.setLabel,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: hintText),
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, TagFormStore store, __) => Observer(
        builder: (_) => MaterialColorPicker(
          allowShades: false,
          elevation: 1.0,
          onMainColorChange: (Color color) {
            store.setColor(color.value);
          },
          selectedColor: Color(store.color),
        ),
      ),
    );
  }
}
