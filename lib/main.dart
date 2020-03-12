import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter/rendering.dart';

import 'src/app_module.dart';
import 'src/app.dart';

void main() {
  // debugPaintPointersEnabled = debugPaintBaselinesEnabled =
  //     debugPaintLayerBordersEnabled = debugRepaintRainbowEnabled = true;
  runApp(
    ModularApp(module: AppModule(App())),
  );
}
