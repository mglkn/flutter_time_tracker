import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../data/dto.dart';
import '../../../data/db.dart';

class TagsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _listTestTags = [
      TagWithPomodorosCount(
        tag: Tag(label: 'programming', color: Colors.purple.value),
        pomodorosCount: 25,
      ),
      TagWithPomodorosCount(
        tag: Tag(label: 'dart', color: Colors.blue.value),
        pomodorosCount: 43,
      ),
      TagWithPomodorosCount(
        tag: Tag(label: 'flutter', color: Colors.orange.value),
        pomodorosCount: 18,
      ),
    ];

    return Container(
      child: ListView(
        padding: EdgeInsets.all(20.0),
        children: _listTestTags.map((t) => TagTile(t)).toList(),
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
