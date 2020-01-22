import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../data/dto.dart';
import '../../../store/home_store.dart';

class TagsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<HomeStore>(
        builder: (_, HomeStore store, __) => Observer(
          builder: (_) => ListView(
            padding: EdgeInsets.all(20.0),
            children: store.tags.map((t) => TagTile(t)).toList(),
          ),
        ),
      ),
    );
  }
}

class TagTile extends StatelessWidget {
  final TagWithPomodorosCount tag;

  TagTile(this.tag);

  @override
  Widget build(BuildContext context) {
    return SlidableWrapper(
      child: Card(
        color: Color(tag.tag.color),
        child: ListTile(
          leading: Text(
            tag.pomodorosCount.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          title: Text(
            tag.tag.label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SlidableWrapper extends StatelessWidget {
  final Widget child;

  SlidableWrapper({this.child});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.2,
      actions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.transparent,
          foregroundColor: Colors.black,
          icon: Icons.done,
          onTap: () {
            print("done");
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.transparent,
          foregroundColor: Colors.black,
          icon: Icons.remove_circle_outline,
          onTap: () {
            print("Delete");
          },
        ),
      ],
      child: child,
    );
  }
}
