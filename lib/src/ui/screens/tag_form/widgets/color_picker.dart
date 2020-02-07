import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../store/tag_form_store.dart';

class ColorPicker extends StatelessWidget {
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
