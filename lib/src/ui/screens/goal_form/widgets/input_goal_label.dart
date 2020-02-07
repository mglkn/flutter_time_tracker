import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../utils/app_localization.dart';
import '../../../../store/goal_form_store.dart';

class InputGoalLabel extends StatefulWidget {
  @override
  _InputGoalLabelState createState() => _InputGoalLabelState();
}

class _InputGoalLabelState extends State<InputGoalLabel> {
  TextEditingController _controller;
  Timer _debounce;

  GoalFormStore _store;

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
    _store = Provider.of<GoalFormStore>(context);
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
    final hintText = AppLocalizations.of(context).translate('enterGoal');

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
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
