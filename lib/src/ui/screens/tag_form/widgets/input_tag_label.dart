import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../utils/app_localization.dart';
import '../../../../store/tag_form_store.dart';

class InputTagLabel extends StatefulWidget {
  @override
  _InputTagLabelState createState() => _InputTagLabelState();
}

class _InputTagLabelState extends State<InputTagLabel> {
  TextEditingController _controller;
  Timer _debounce;

  TagFormStore _store = Modular.get<TagFormStore>();

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
  void initState() {
    _controller = TextEditingController(text: _store.label);
    _controller.addListener(_onFieldChanged);
    super.initState();
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

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Observer(
        builder: (_) => TextFormField(
          controller: _controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[400],
            hintText: hintText,
            errorText: _store.errorLabel,
          ),
        ),
      ),
    );
  }
}
