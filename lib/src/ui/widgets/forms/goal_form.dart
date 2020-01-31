import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/app_localization.dart';
import '../../../store/goal_form_store.dart';
import '../../../data/dto.dart';

class GoalForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * .9,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _InputTextField(),
            const SizedBox(height: 20.0),
            Expanded(
              child: _TagSelector(),
            ),
          ],
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

class _TagSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalFormStore store, __) => Observer(
        builder: (_) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            itemCount: store.allTags.length,
            itemBuilder: (_, index) => Container(
              child: TagSelectorItem(
                tag: store.allTags[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TagSelectorItem extends StatefulWidget {
  final TagWithPomodorosCount tag;

  TagSelectorItem({this.tag}) : assert(tag != null);

  @override
  _TagSelectorItemState createState() => _TagSelectorItemState();
}

class _TagSelectorItemState extends State<TagSelectorItem> {
  bool isTagSelected = false;

  @override
  void initState() {
    super.initState();
    final store = Provider.of<GoalFormStore>(context, listen: false);
    if (store.isTagSelected(widget.tag)) {
      isTagSelected = true;
    }
  }

  void _toggleTagSelection(GoalFormStore store) {
    store.toggleTagSelection(widget.tag);
    setState(() {
      isTagSelected = !isTagSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _tag = widget.tag.tag;

    return Consumer(
      builder: (_, GoalFormStore store, __) => Container(
        child: GestureDetector(
          onTap: () => _toggleTagSelection(store),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            margin: EdgeInsets.only(bottom: 5.0),
            decoration: BoxDecoration(
              color: Color(_tag.color),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    _tag.label,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  child: isTagSelected
                      ? Icon(
                          Icons.radio_button_checked,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.radio_button_unchecked,
                          color: Colors.white,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
