// ignore_for_file: invalid_annotation_target

import 'package:home_tasks_app/repositories/models/task/task.dart';
import 'package:home_tasks_app/repositories/task_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class TaskUseCase {
  TaskUseCase(
    @injectable this._taskRepository,
  );
  late final TaskRepository _taskRepository;

  Future<List<Task>?> getTask(String roomId) async {
    try {
      return await _taskRepository.getTasks(roomId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> editTask({
    required Task task,
    required String roomId,
  }) async {
    try {
      return await _taskRepository.editTask(
        task: task,
        roomId: roomId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteTask({
    required String taskId,
  }) async {
    try {
      return await _taskRepository.deleteTask(
        taskId: taskId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> addTask({
    required Task task,
    required String roomId,
  }) async {
    try {
      return await _taskRepository.addTask(
        task: task,
        roomId: roomId,
      );
    } catch (error) {
      rethrow;
    }
  }
}
