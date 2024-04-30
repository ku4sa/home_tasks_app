import '../../repositories/models/room/room.dart';

class RoomEditorPageState {
  final Room? room;
  final bool isValid;
  final String? message;

  RoomEditorPageState({
    this.room,
    this.isValid = false,
    this.message,
  });

  RoomEditorPageState copyWith({
    bool? isValid,
    Room? room,
    String? message,
  }) {
    return RoomEditorPageState(
      room: room ?? this.room,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
    );
  }
}
