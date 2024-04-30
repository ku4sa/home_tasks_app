import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/auth_repository.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/repositories/utils/dio.dart';
import 'package:injectable/injectable.dart';
import 'models/user/user.dart';
import 'utils/exception.dart';

@singleton
class GroupRepository {
  late MyDio _dio;
  late User? _user;
  final ValueNotifier<GroupOfRooms?> activeGroupOfRooms = ValueNotifier(null);

  GroupRepository() {
    _dio = GetIt.instance<MyDio>();
  }

  Future<void> selectGroup(GroupOfRooms group) async {
    activeGroupOfRooms.value = group;
  }

  List<User>? getUsers() {
    final list = activeGroupOfRooms.value?.users;
    if (list != null && list.isNotEmpty) {
      return List<User>.generate(list.length, (index) {
        return User(
          username: list[index],
        );
      });
    } else {
      return null;
    }
  }

  Future<void> init() async {
    _user = GetIt.instance<AuthorizationRepository>().activeUser.value;
    if (_user == null) throw Exception("User not authorized");
  }

  Future<List<GroupOfRooms>?> getGroup() async {
    Response? response;
    try {
      response = await _dio.dio.get(
        'groupes/${_user!.username}',
      );
      if (response.statusCode == 200) {
        List<GroupOfRooms> groupes = List<GroupOfRooms>.from(
          response.data.map(
            (model) => GroupOfRooms.fromJson(model),
          ),
        );
        return groupes;
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

  Future<List<GroupOfRooms>?> getPublishGroupes() async {
    Response? response;
    try {
      response = await _dio.dio.get(
        'groupes/publish/${_user!.username}',
      );
      if (response.statusCode == 200) {
        List<GroupOfRooms> groupes = [];
        print("test");
        (response.data as List<dynamic>).forEach(
          (element) {
            groupes.add(GroupOfRooms.fromJson(element));
          },
        );
        print("test");
        return groupes;
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

  Future<void> editGroup(
      {required String groupId,
      required String name,
      String? describtion}) async {
    Response? response;
    try {
      response = await _dio.dio.put(
        'groupes',
        queryParameters: {
          "GroupId": groupId,
          "name": name,
          "describtion": describtion,
          "dateUpdate": DateTime.now(),
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

  Future<void> deleteGroup({
    required String groupId,
  }) async {
    Response? response;
    try {
      response = await _dio.dio.delete(
        'groupes/${_user!.username}',
        queryParameters: {
          "GroupID": groupId,
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

  Future<String?> addGroup({required String name, String? describtion}) async {
    Response? response;
    try {
      response = await _dio.dio.post(
        'groupes/${_user!.username}',
        queryParameters: {
          "name": name,
          "describtion": describtion,
        },
      );
      if (response.statusCode == 200) {
        GroupOfRooms group = GroupOfRooms.fromJson(response.data);

        return group.id;
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

  Future<void> addFUserToGroupOfRoom(
      {required String username, required String groupId}) async {
    Response? response;
    try {
      response = await _dio.dio.post(
        'groupes/publish',
        queryParameters: {
          "username": username,
          "groupID": groupId,
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

  Future<void> deleteUserFromGroupOfRoom(
      {required String username, required String groupId}) async {
    Response? response;
    try {
      response = await _dio.dio.delete(
        'groupes/publish',
        queryParameters: {
          "username": username,
          "groupID": groupId,
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
}
