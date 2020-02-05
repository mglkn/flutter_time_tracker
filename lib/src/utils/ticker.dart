class Ticker {
  Stream<int> tick({int ticks}) {
    return Stream<int>.periodic(
        Duration(milliseconds: 10), (x) => ticks - x - 1).take(ticks);
  }
}
