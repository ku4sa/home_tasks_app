import 'package:home_tasks_app/repositories/models/task/task.dart';

class TaskEditorPageState {
  final Task? task;
  final bool isValid;
  final String? message;

  TaskEditorPageState({
    this.task,
    this.isValid = false,
    this.message,
  });

  TaskEditorPageState copyWith({
    bool? isValid,
    Task? task,
    String? message,
  }) {
    return TaskEditorPageState(
      task: task ?? this.task,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
    );
  }
}
