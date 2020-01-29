import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/app_localization.dart';
import '../../../store/tag_form_store.dart';

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
              _InputTextField(),
              const SizedBox(height: 20.0),
              Expanded(child: _ColorPicker()),
            ],
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
  TextEditingController _controller;
  Timer _debounce;

  TagFormStore _store;

  _onFieldChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        if (_controller.value.text.trim() != _store.label)
          _store.setLabel(_controller.value.text.trim());
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<TagFormStore>(context);
    _controller = TextEditingController(text: _store.label);
    _controller.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onFieldChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hintText = AppLocalizations.of(context).translate('enterTag');

    return Consumer(
      builder: (_, TagFormStore store, __) => Observer(
        builder: (_) => TextFormField(
          controller: _controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: store.errorLabel,
          ),
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
