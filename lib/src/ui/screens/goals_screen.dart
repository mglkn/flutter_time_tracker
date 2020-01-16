import 'package:flutter/material.dart';
import '../../routes/router.gr.dart';

class GoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('goals'),
            RaisedButton(
              child: Text("Go to tags"),
              onPressed: () {
                AppRouter.navigator.pushNamed(AppRouter.tagsScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
