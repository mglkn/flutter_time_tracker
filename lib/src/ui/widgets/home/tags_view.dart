import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../data/dto.dart';
import '../../../store/home_store.dart';
import '../../../routes/router.gr.dart';
import '../../../utils/theme.dart';

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
    return _SlidableWrapper(
      tag: tag,
      child: Container(
        // color: Color(tag.tag.color),
        margin: EdgeInsets.only(bottom: 15.0),
        decoration: tileDecoration.copyWith(
          color: Color(tag.tag.color),
        ),
        child: ListTile(
          leading: Text(
            tag.pomodorosCount.toString(),
            style: Theme.of(context).textTheme.subtitle.copyWith(
                  color: Colors.white,
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

class _SlidableWrapper extends StatelessWidget {
  final Widget child;
  final TagWithPomodorosCount tag;

  _SlidableWrapper({
    this.child,
    this.tag,
  })  : assert(tag != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, HomeStore store, __) => Slidable(
        actionPane: SlidableBehindActionPane(),
        actionExtentRatio: 0.2,
        actions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.transparent,
            foregroundColor: Colors.black,
            icon: Icons.done,
            onTap: () {
              AppRouter.navigator
                  .pushNamed(AppRouter.tagFormScreen, arguments: tag);
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
              store.deleteTag(tag);
            },
          ),
        ],
        child: child,
      ),
    );
  }
}
