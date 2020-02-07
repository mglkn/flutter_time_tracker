import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../store/goal_form_store.dart';
import '../../../../data/dto.dart';

class TagSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, GoalFormStore store, __) => Observer(
        builder: (_) {
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
      ),
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
