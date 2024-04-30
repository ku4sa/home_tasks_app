import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/models/task/task.dart';
import 'package:home_tasks_app/repositories/utils/dio.dart';
import 'package:injectable/injectable.dart';
import 'utils/exception.dart';

@singleton
class TaskRepository {
  late final MyDio _dio;

  TaskRepository() {
    _dio = GetIt.instance<MyDio>();
  }

  Future<List<Task>?> getTasks(String roomId) async {
    Response? response;
    try {
      response = await _dio.dio.get(
        '/$roomId/tasks',
      );
      if (response.statusCode == 200) {
        List<Task> tasks = [];

        for (var element in (response.data as List<dynamic>)) {
          tasks.add(Task.fromJson(element));
        }

        return tasks;
      } else {
        var result = response.data as String;
        throw AppException(response.statusCode!, message: result);
      }
    } on DioException catch (error) {
      throw AppException(error.response!.statusCode!,
          message: error.response!.data as String);
    } on Error catch (error) {
      print(error);
    }
    return null;
  }

  Future<void> editTask({
    required Task task,
    required String roomId,
  }) async {
    Response? response;
    try {
      response = await _dio.dio.put(
        'tasks',
        queryParameters: {
          "roomId": roomId,
          "task": task,
        },
      );
      if (response.statusCode != 200) {
        var result = response.data as String;
        throw AppException(
          response.statusCode!,
          message: result,
        );
      }
    } on DioException catch (error) {
      throw AppException(
        error.response!.statusCode!,
        message: error.response!.data as String,
      );
    } on Error catch (error) {
      print(error);
    }
  }

  Future<void> deleteTask({
    required String taskId,
  }) async {
    Response? response;
    try {
      response = await _dio.dio.delete(
        'tasks',
        queryParameters: {
          "taskId": taskId,
        },
      );
      if (response.statusCode != 200) {
        var result = response.data as String;
        throw AppException(
          response.statusCode!,
          message: result,
        );
      }
    } on DioException catch (error) {
      throw AppException(
        error.response!.statusCode!,
        message: error.response!.data as String,
      );
    } on Error catch (error) {
      print(error);
    }
  }

  Future<String?> addTask({
    required String roomId,
    required Task task,
  }) async {
    Response? response;
    try {
      response = await _dio.dio.post(
        options: Options(headers: {"Content-Type": "application/json"}),
        '/tasks',
        queryParameters: {
          "roomId": roomId,
        },
        data: task.toJson(),
      );
      if (response.statusCode == 200) {
        if (response.data is String) {
          return response.data!;
        }
        throw AppException(
          -1,
          message: "Неожиданный  ответ",
        );
      } else {
        var result = response.data as String;
        throw AppException(response.statusCode!, message: result);
      }
    } on DioException catch (error) {
      throw AppException(
        error.response!.statusCode!,
        message: error.response!.data as String,
      );
    } on Error catch (error) {
      print(error);
    }
    return null;
  }
}
