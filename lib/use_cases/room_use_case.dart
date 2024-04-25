// ignore_for_file: invalid_annotation_target

import 'package:home_tasks_app/repositories/models/room/room.dart';
import 'package:injectable/injectable.dart';
import '../repositories/room_repository.dart';

@injectable
class RoomUseCase {
  RoomUseCase(
    @injectable this._roomRepository,
  );
  late final RoomRepository _roomRepository;
  Future<void> init() async {
    await _roomRepository.init();
  }

  Future<List<Room>?> getRoom(String groupId) async {
    try {
      return await _roomRepository.getRoom(groupId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> editRoom({
    required String roomId,
    required String name,
    String? describtion,
  }) async {
    try {
      return await _roomRepository.editRoom(
        roomId: roomId,
        name: name,
        describtion: describtion,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteRoom({
    required String roomId,
  }) async {
    try {
      return await _roomRepository.deleteRoom(
        roomId: roomId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> addRoom({
    required String name,
    String? describtion,
    required String groupId,
  }) async {
    try {
      return await _roomRepository.addRoom(
        groupId: groupId,
        name: name,
        describtion: describtion,
      );
    } catch (error) {
      rethrow;
    }
  }
}
