
import '../../repositories/models/room/room.dart';
import '../../repositories/models/task/task.dart';

class TaskPageState {
  final Room room;
  final List<Task> tasks;
  final bool inProcces;
  final String? message;

  TaskPageState({
    required this.room,
    required this.tasks,
    this.inProcces = false,
    this.message,
  });

  TaskPageState copyWith({
    Room? room,
    bool? inProcces,
    List<Task>? tasks,
    String? message,
  }) {
    return TaskPageState(
      room: room ?? this.room,
      tasks: tasks ?? this.tasks,
      inProcces: inProcces ?? this.inProcces,
      message: message ?? this.message,
    );
  }
}
