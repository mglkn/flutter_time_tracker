import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/app_localization.dart';
import '../../../store/goal_form_store.dart';
import '../../../data/dto.dart';

class GoalForm extends StatelessWidget {
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
      ),
    );
  }
}

class _InputTextField extends StatefulWidget {
  @override
  __InputTextFieldState createState() => __InputTextFieldState();
}

class __InputTextFieldState extends State<_InputTextField> {
  @override
  Widget build(BuildContext context) {
    final hintText = AppLocalizations.of(context).translate('enterGoal');

    return Consumer(
      builder: (_, GoalFormStore store, __) => Observer(
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

class _TagSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalFormStore store, __) => Observer(
        builder: (_) {
          return ListView.builder(
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
      builder: (_, GoalFormStore store, __) => Card(
        color: Color(_tag.color),
        child: ListTile(
          onTap: () => _toggleTagSelection(store),
          title: Text(
            _tag.label,
            style: TextStyle(color: Colors.white),
          ),
          trailing: isTagSelected
              ? Icon(
                  Icons.done,
                  color: Colors.white,
                )
              : Text(''),
        ),
      ),
    );
  }
}
