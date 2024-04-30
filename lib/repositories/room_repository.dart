import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/auth_repository.dart';
import 'package:home_tasks_app/repositories/models/room/room.dart';
import 'package:home_tasks_app/repositories/utils/dio.dart';
import 'package:injectable/injectable.dart';
import 'models/user/user.dart';
import 'utils/exception.dart';

@singleton
class RoomRepository {
  late final MyDio _dio;
  late User? _user;

  RoomRepository() {
    _dio = GetIt.instance<MyDio>();
  }

  Future<void> init() async {
    _user = GetIt.instance<AuthorizationRepository>().activeUser.value;
    if (_user == null) throw Exception("User not authorized");
  }

  Future<List<Room>?> getRoom(String groupId) async {
    Response? response;
    try {
      response = await _dio.dio.get(
        '/$groupId/rooms',
      );
      if (response.statusCode == 200) {
        List<Room> rooms = [];

        (response.data as List<dynamic>).forEach(
          (element) {
            rooms.add(Room.fromJson(element));
          },
        );

        return rooms;
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

  Future<void> editRoom(
      {required String roomId,
      required String name,
      String? describtion}) async {
    Response? response;
    try {
      response = await _dio.dio.put(
        'rooms',
        queryParameters: {
          "id": roomId,
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

  Future<void> deleteRoom({
    required String roomId,
  }) async {
    Response? response;
    try {
      response = await _dio.dio.delete(
        'rooms',
        queryParameters: {
          "groupId": roomId, //TODO:поправить в серверной части
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

  Future<String?> addRoom({
    required String name,
    String? describtion,
    required groupId,
  }) async {
    Response? response;
    try {
      response = await _dio.dio.post(
        '$groupId/rooms',
        queryParameters: {
          "name": name,
          "describtion": describtion,
          "dateUpdate": DateTime.now(),
        },
      );
      if (response.statusCode == 200) {
        Room group = Room.fromJson(response.data);

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
}
