import 'package:flutter/material.dart';
import 'package:time_tracker/src/utils/app_localization.dart';

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
        child: Container(
          padding: EdgeInsets.all(20.0),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _InputTextField(),
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
