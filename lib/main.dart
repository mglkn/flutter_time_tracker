import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/rendering.dart';

import './src/app_module.dart';
// import './src/store/home_store.dart';

void main() {
  // debugPaintPointersEnabled = debugPaintBaselinesEnabled =
  //     debugPaintLayerBordersEnabled = debugRepaintRainbowEnabled = true;
  runApp(
    ModularApp(module: AppModule()),
    // Provider<HomeStore>(
    //   create: (_) => HomeStore(),
    //   child: App(),
    // ),
  );
}
