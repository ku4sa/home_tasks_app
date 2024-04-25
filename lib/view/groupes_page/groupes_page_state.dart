import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';


class GroupPageState {
  final List<GroupOfRooms> groupes;
  final bool inProcces;
  final String? message;

  GroupPageState({
    required this.groupes,
    this.inProcces = false,
    this.message,
  });

  GroupPageState copyWith({
    bool? inProcces,
    List<GroupOfRooms>? groupes,
    String? message,
  }) {
    return GroupPageState(
      groupes: groupes ?? this.groupes,
      inProcces: inProcces ?? this.inProcces,
      message: message ?? this.message,
    );
  }
}
