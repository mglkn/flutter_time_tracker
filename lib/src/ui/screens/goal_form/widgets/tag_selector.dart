import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../store/goal_form_store.dart';
import '../../../../data/dto.dart';
import '../../../../utils/app_localization.dart';

class TagSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoalFormStore store = Modular.get<GoalFormStore>();

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
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          itemCount: store.allTags.length,
          itemBuilder: (_, index) => Container(
            child: _TagSelectorItem(
              tag: store.allTags[index],
            ),
          ),
        );
      },
    );
  }
}

class _TagSelectorItem extends StatefulWidget {
  final TagWithPomodorosCount tag;

  _TagSelectorItem({this.tag}) : assert(tag != null);

  @override
  __TagSelectorItemState createState() => __TagSelectorItemState();
}

class __TagSelectorItemState extends State<_TagSelectorItem> {
  bool isTagSelected = false;

  @override
  void initState() {
    super.initState();
    final GoalFormStore store = Modular.get<GoalFormStore>();
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
    final GoalFormStore store = Modular.get<GoalFormStore>();

    return Container(
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
    );
  }
}
