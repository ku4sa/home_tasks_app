// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
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
    int? daysInterval,
    @JsonKey(name: 'minutes') int? leadTime,
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

  @override
  int? getCount() {
    //возвращает число дней до выполнения задачи
    if (daysInterval != null) {
      return daysInterval! - DateTime.now().difference(date).inDays;
    } else {
      return DateTime.now().difference(date).inDays;
    }
  }

  @override
  String? getDescribtion() {
    return describtion;
  }
}
