import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  final int someNum;
  final List<String> someNames;

  TestScreen({
    @required this.someNum,
    @required this.someNames,
  });

  @override
  Widget build(BuildContext context) {
    print('>>>> $someNum $someNames');

    return Scaffold(
      body: Center(
        child: Text('test screen'),
      ),
    );
  }
}
