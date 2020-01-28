import 'package:flutter/services.dart';

class Ticker {
  static const EventChannel _eventChannel =
      const EventChannel('time_tracker/ticker');

  Stream<int> tick({int ticks}) {
    return _eventChannel.receiveBroadcastStream(ticks).map<int>((i) => i);
  }
}
