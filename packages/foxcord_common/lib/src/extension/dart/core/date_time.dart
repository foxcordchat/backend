extension DateTimeExtension on DateTime {
  int get secondsSinceEpoch =>
      millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
}
