import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/rendering.dart';

import './src/app.dart';
import './src/store/home_store.dart';

void main() {
  // debugPaintPointersEnabled = debugPaintBaselinesEnabled =
  //     debugPaintLayerBordersEnabled = debugRepaintRainbowEnabled = true;
  runApp(
    Provider<HomeStore>(
      create: (_) => HomeStore(),
      child: App(),
    ),
  );
}
