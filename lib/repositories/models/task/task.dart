// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:home_tasks_app/repositories/models/interval/interval.dart';
import 'package:home_tasks_app/repositories/models/status/status.dart';
import 'package:home_tasks_app/repositories/models/task_type/task_type.dart';
import '../data_model.dart';
part 'task.freezed.dart';
part 'task.g.dart';

@Freezed()
class Task extends DataModel with _$Task {
  factory Task({
    String? id,
    String? describtion,
    required String name,
    required int type,
    required int status,
    required int priority,
    String? user,
    required DateTime date,
    IntervalType? interval,
    IntervalType? leadTime,
    required int countRepeats,
    required int countSkips,
    required DateTime dateUpdate,
  }) = _Task;

  Task._();

  TaskType? getType() {
    return TaskType(type: type);
  }

  Status? getStatus() {
    return Status(status: status);
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  @override
  String getName() {
    return name;
  }

  Map<int, int>? getIntervalView() {
    if (interval != null && type == 2) {

      final count = interval!.getYears();
      if (interval!.getYears() > 0) {
        return {365: interval!.getYears()};
      } else if (interval!.getMounth() > 0) {
        return {30: interval!.getMounth()};
      } else if (interval!.getWeeks() > 0) {
        return {7: interval!.getMounth()};
      } else {
        return {1: interval!.days};
      }
    } else {
      return null;
    }
  }

  String? getDaysToNeedToDo() {
    if (interval != null) {
      final time = DateTime.now() //сегодняшнее число минус
          .difference(date
              .subtract(interval!.toDuration())); //дата следующего интервала

      if (time.isNegative) {
        return "Просрочена на ${time.inDays}";
      } else {
        final interval = IntervalType.fromDuration(time);
        if (interval.getYears() > 0) {
          return "Через ${interval.getYears()} год";
        } else if (interval.getMounth() > 0) {
          return "Через ${interval.getMounth()} месяц";
        } else if (interval.getWeeks() > 0) {
          final number = interval.getWeeks();
          if (number == 1) {
            return "Через неделю";
          }
          return "Через $number недели";
        } else if (interval.days == 0) {
          return "завтра";
        } else {
          return 'Через ${interval.days} дня';
        }
      }
    } else {
      return "До $date";
    }
  }

  @override
  String? getDescribtion() {
    return describtion;
  }

  @override
  int? getCount() {
    return null;
  }
}
