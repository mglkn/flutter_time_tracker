import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../store/tag_form_store.dart';
import '../../../../utils/app_localization.dart';

class ColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TagFormStore store = Modular.get<TagFormStore>();

    return Observer(
      builder: (_) {
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

        return MaterialColorPicker(
          allowShades: false,
          elevation: 1.0,
          onMainColorChange: (Color color) {
            store.setColor(color.value);
          },
          selectedColor: Color(store.color),
        );
      },
    );
  }
}
