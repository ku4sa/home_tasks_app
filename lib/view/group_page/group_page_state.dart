import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';

import '../authorization_page/models/describtion.dart';
import '../authorization_page/models/name.dart';

class GroupEditorPageState {
  final Name name;
  final Describtion describtion;
  final GroupOfRooms? group;
  final bool isValid;
  final String? message;


  GroupEditorPageState({
    required this.name,
    required this.describtion,
    this.group,
    this.isValid = false,
    this.message,
  });

  GroupEditorPageState copyWith({
    Name? name,
    Describtion? describtion,
    bool? isValid,
    GroupOfRooms? group,
    String? message,
  }) {
    return GroupEditorPageState(
      name: name ?? this.name,
      describtion: describtion ?? this.describtion,
      group: group ?? this.group,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
    );
  }
}
