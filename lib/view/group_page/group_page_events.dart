import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';

abstract class GroupEditorPageEvent {}

final class CreatorOpened extends GroupEditorPageEvent {}

final class EditorOpened extends GroupEditorPageEvent {
  final GroupOfRooms group;
  EditorOpened({required this.group});
}

final class ChangeName extends GroupEditorPageEvent {
  final String name;
  ChangeName({required this.name});
}

final class ImportSettings extends GroupEditorPageEvent {
  final GroupOfRooms group;
  ImportSettings({required this.group});
}

final class ChangeDescribtion extends GroupEditorPageEvent {
  final String describtion;
  ChangeDescribtion({required this.describtion});
}

final class DeleteUser extends GroupEditorPageEvent {
  final String username;
  DeleteUser({required this.username});
}

final class AddUser extends GroupEditorPageEvent {
  final String username;
  AddUser({required this.username});
}

final class OnSubbmit extends GroupEditorPageEvent {
  final GroupOfRooms group;
  OnSubbmit({required this.group});
}
