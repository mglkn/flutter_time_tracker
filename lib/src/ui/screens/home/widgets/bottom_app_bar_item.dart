import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final Color color =
        isSelected ? Theme.of(context).accentColor : Colors.grey[600];

    return GestureDetector(
      onTap: () => selectCallback(index: index, store: store),
      child: Container(
        key: Key('${ConstantKeys.bottomBarItem}$title'.toLowerCase()),
        height: 60.0,
        child: Column(
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
        ),
      ),
    );
  }
}
