import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../data/dto.dart';
import '../../../store/home_store.dart';
import '../../../routes/router.gr.dart';
import '../../../utils/theme.dart';
import '../../../utils/app_icons.dart';

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
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: tileDecoration.copyWith(
          color: Color(tag.tag.color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _PomodorosCount(tag),
            Text(
              tag.tag.label,
              style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
            )
          ],
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

class _PomodorosCount extends StatelessWidget {
  final TagWithPomodorosCount tag;

  _PomodorosCount(this.tag) : assert(tag != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 60.0,
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              AppIcons.pomodoro,
              size: 55.0,
              color: Colors.white,
            ),
          ),
          Center(
            child: Text(
              tag.pomodorosCount.toString(),
              style: Theme.of(context).textTheme.subtitle.copyWith(
                shadows: [
                  BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
