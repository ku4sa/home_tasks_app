import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/repositories/models/room/room.dart';

class RoomPageState {
  final List<GroupOfRooms> groupes;
  final GroupOfRooms? selectedGroup;
  final List<Room> rooms;
  final bool inProcces;
  final String? message;

  RoomPageState({
    required this.groupes,
    required this.rooms,
    this.inProcces = false,
    this.message,
    this.selectedGroup,
  });

  RoomPageState copyWith({
    List<Room>? rooms,
    bool? inProcces,
    List<GroupOfRooms>? groupes,
    String? message,
    GroupOfRooms? selectedGroup,
  }) {
    return RoomPageState(
      rooms: rooms ?? this.rooms,
      groupes: groupes ?? this.groupes,
      inProcces: inProcces ?? this.inProcces,
      message: message ?? this.message,
      selectedGroup: selectedGroup ?? this.selectedGroup,
    );
  }
}
