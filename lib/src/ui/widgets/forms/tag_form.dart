import 'package:flutter/material.dart';
import 'package:time_tracker/src/utils/app_localization.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

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

class _InputTextField extends StatefulWidget {
  @override
  __InputTextFieldState createState() => __InputTextFieldState();
}

class __InputTextFieldState extends State<_InputTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hintText = AppLocalizations.of(context).translate('enterTag');

    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialColorPicker(
      allowShades: false,
      elevation: 1.0,
      onMainColorChange: (Color color) {
        print(color);
        // store.setColor(color);
      },
      // selectedColor: store.color,
    );
  }
}
