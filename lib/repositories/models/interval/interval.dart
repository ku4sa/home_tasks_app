import 'package:freezed_annotation/freezed_annotation.dart';

part 'interval.freezed.dart';

part 'interval.g.dart';

@freezed
abstract class IntervalType with _$IntervalType {
  const IntervalType._();
  const factory IntervalType({
    @Default(0) int days,
    @Default(0) int hours,
    @Default(0) int minutes,
    @Default(0) int seconds,
    @Default(0) int milliseconds,
    @Default(0) int ticks,
  }) = _Interval;

  /// Converts the `Interval` to a `Duration` object.
  Duration toDuration() {
    return Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: ticks * 1000, // Convert ticks to microseconds
    );
  }

  int getYears() {
    return days ~/ 365;
  }

  int getWeeks() {
    return days ~/ 7;
  }

  int getMounth() {
    return days ~/ 30;
  }

  factory IntervalType.fromCountAndValue(int count, int type) {
    return IntervalType(days: count * type);
  }

  /// Factory constructor for creating `Interval` from a `Duration`.
  factory IntervalType.fromDuration(Duration duration) {
    return IntervalType(
      days: duration.inDays,
      hours: duration.inHours % 24, // Get hours within a day
      minutes: duration.inMinutes % 60, // Get minutes within an hour
      seconds: duration.inSeconds % 60, // Get seconds within a minute
      milliseconds:
          duration.inMilliseconds % 1000, // Get milliseconds within a second
      ticks:
          (duration.inMicroseconds / 1000).floor(), // Get ticks (rounded down)
    );
  }

  /// Converts the `Interval` to a JSON-compatible map.
  factory IntervalType.fromJson(Map<String, dynamic> json) =>
      _$IntervalTypeFromJson(json);
}
