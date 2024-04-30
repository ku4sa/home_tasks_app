import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';

class GroupEditorPageState {
  final GroupOfRooms? group;
  final bool isValid;
  final String? message;

  GroupEditorPageState({
    this.group,
    this.isValid = false,
    this.message,
  });

  GroupEditorPageState copyWith({
    bool? isValid,
    GroupOfRooms? group,
    String? message,
  }) {
    return GroupEditorPageState(
      group: group ?? this.group,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
    );
  }
}
