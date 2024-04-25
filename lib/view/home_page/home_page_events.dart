import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/repositories/models/room/room.dart';

abstract class RoomPageEvent {}

final class RoomPageOpened extends RoomPageEvent {}

final class UpdatePage extends RoomPageEvent {}

final class AddRoom extends RoomPageEvent {
  final Room room;
  AddRoom({required this.room});
}

final class DeleteRoom extends RoomPageEvent {
  final Room room;
  DeleteRoom({required this.room});
}

final class EditRoom extends RoomPageEvent {
  final Room room;
  EditRoom({required this.room});
}

final class SwapGroup extends RoomPageEvent {
  final GroupOfRooms group;
  SwapGroup({required this.group});
}
