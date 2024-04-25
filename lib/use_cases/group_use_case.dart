// ignore_for_file: invalid_annotation_target

import 'package:home_tasks_app/repositories/group_repository.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:injectable/injectable.dart';

//TODO: добавить базу данных где хранить только свои группы комнат и задачи

@injectable
class GroupUseCase {
  GroupUseCase(
    @injectable this._groupRepository,
  );
  late final GroupRepository _groupRepository;

  Future<void> init() async {
    await _groupRepository.init();
  }

  Future<List<GroupOfRooms>?> getGroup() async {
    try {
      return await _groupRepository.getGroup();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<GroupOfRooms>?> getPublishGroupes() async {
    try {
      return await _groupRepository.getPublishGroupes();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> editGroup(
      {required String groupId,
      required String name,
      String? describtion}) async {
    try {
      return await _groupRepository.editGroup(
        groupId: groupId,
        name: name,
        describtion: describtion,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteGroup({
    required String groupId,
  }) async {
    try {
      return await _groupRepository.deleteGroup(
        groupId: groupId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> addGroup({required String name, String? describtion}) async {
    try {
      return await _groupRepository.addGroup(
          name: name, describtion: describtion);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addUserToGroupOfRoom(
      {required String username, required String groupId}) async {
    try {
      return await _groupRepository.addFUserToGroupOfRoom(
          username: username, groupId: groupId);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteUserFromGroupOfRoom(
      {required String username, required String groupId}) async {
    try {
      return await _groupRepository.deleteUserFromGroupOfRoom(
          username: username, groupId: groupId);
    } catch (error) {
      rethrow;
    }
  }
}
