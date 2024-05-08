import 'package:home_tasks_app/repositories/models/task/task.dart';

class TaskEditorPageState {
  final Task? task;
  final int? countValue;
  final int? typeValue;
  final bool isValid;
  final String? message;

  TaskEditorPageState({
    this.task,
    this.isValid = false,
    this.message,
    this.countValue,
    this.typeValue,
  });

  TaskEditorPageState copyWith({
    bool? isValid,
    Task? task,
    String? message,
    int? countValue,
    int? typeValue,
  }) {
    return TaskEditorPageState(
      task: task ?? this.task,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
      countValue: countValue ?? this.countValue,
      typeValue: typeValue ?? this.typeValue,
    );
  }
}
