import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';

class TagsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('tags'),
            RaisedButton(
              child: Text("Go to tags"),
              onPressed: () {
                AppRouter.navigator.pushNamed(
                  AppRouter.testScreen,
                  arguments: TestScreenArguments(
                    someNum: 1,
                    someNames: ['hello', 'there'],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
