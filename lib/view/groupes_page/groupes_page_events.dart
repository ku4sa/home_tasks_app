import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';

abstract class GroupPageEvent {}

final class GroupPageOpened extends GroupPageEvent {}

final class PageUpdated extends GroupPageEvent {}

final class AddGroup extends GroupPageEvent {
  final GroupOfRooms group;
  AddGroup({required this.group});
}

final class DeleteGroup extends GroupPageEvent {
  final GroupOfRooms group;
  DeleteGroup({required this.group});
}

final class EditGroup extends GroupPageEvent {
  final GroupOfRooms group;
  EditGroup({required this.group});
}

final class SearchGroup extends GroupPageEvent {
  final String value;
  SearchGroup({required this.value});
}
