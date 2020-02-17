import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../../store/home_store.dart';
import '../../../../utils/constant_keys.dart';

class BottomAppBarItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function({HomeStore store, int index}) selectCallback;
  final int index;

  BottomAppBarItem({
    this.iconData,
    this.title,
    this.selectCallback,
    this.index,
  })  : assert(iconData != null),
        assert(title != null),
        assert(index != null),
        assert(selectCallback != null);

  @override
  Widget build(BuildContext context) {
    final HomeStore store = Provider.of<HomeStore>(context, listen: false);
    final isSelected = store.pageIndex == index;
    final accentColor = Theme.of(context).accentColor;
    final Color color = isSelected ? accentColor : Colors.grey[600];

    final tween = MultiTrackTween([
      Track('color').add(
        const Duration(milliseconds: 300),
        ColorTween(begin: accentColor, end: Colors.grey[600]),
      ),
      Track('scale').add(
        const Duration(milliseconds: 300),
        Tween(begin: .8, end: 1.0),
      ),
    ]);

    return GestureDetector(
      onTap: () => selectCallback(index: index, store: store),
      child: ControlledAnimation(
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300),
        playback: isSelected ? Playback.PLAY_FORWARD : Playback.PLAY_REVERSE,
        tween: tween,
        builder: (_, animations) => Transform.scale(
          scale: animations['scale'],
          child: Container(
            key: Key('${ConstantKeys.bottomBarItem}$title'.toLowerCase()),
            height: 60.0,
            width: 80.0,
            color: Theme.of(context).backgroundColor,
            child: _BottomAppBarItemData(
              color: color,
              iconData: iconData,
              title: title,
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomAppBarItemData extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color color;

  _BottomAppBarItemData({this.iconData, this.title, this.color})
      : assert(iconData != null),
        assert(title != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(
          iconData,
          color: color,
        ),
        Text(
          title,
          style: TextStyle(
            color: color,
          ),
        ),
      ],
    );
  }
}
