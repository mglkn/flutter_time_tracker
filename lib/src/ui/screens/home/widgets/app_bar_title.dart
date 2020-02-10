import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String titleGoals;
  final String titleTags;
  final double pagePosition;

  AppBarTitle({this.titleGoals, this.titleTags, this.pagePosition});

  @override
  Widget build(BuildContext context) {
    final yPositionGoals = -(pagePosition ?? 0) * 3;
    final yPositionTags = ((1.0 - pagePosition) ?? 0) * 3;

    return Container(
      height: 60.0,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, yPositionGoals),
            child: Text(
              titleGoals,
              style: Theme.of(context).textTheme.title.copyWith(
                    letterSpacing: 12.0,
                  ),
            ),
          ),
          Align(
            alignment: Alignment(0, yPositionTags),
            child: Text(
              titleTags,
              style: Theme.of(context).textTheme.title.copyWith(
                    letterSpacing: 12.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
