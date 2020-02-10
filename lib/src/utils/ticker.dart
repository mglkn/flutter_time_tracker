class Ticker {
  Stream<int> tick({int ticks}) {
    return Stream<int>.periodic(
        Duration(milliseconds: 1000), (x) => ticks - x - 1).take(ticks);
  }
}
