import 'package:home_tasks_app/repositories/models/room/room.dart';

abstract class RoomEditorPageEvent {}

final class CreatorOpened extends RoomEditorPageEvent {}

final class EditorOpened extends RoomEditorPageEvent {
  final Room room;
  EditorOpened({required this.room});
}

final class ChangeName extends RoomEditorPageEvent {
  final String name;
  ChangeName({required this.name});
}

final class ImportSettings extends RoomEditorPageEvent {
  final Room room;
  ImportSettings({required this.room});
}

final class ChangeDescribtion extends RoomEditorPageEvent {
  final String describtion;
  ChangeDescribtion({required this.describtion});
}

final class OnSubbmit extends RoomEditorPageEvent {
  final Room room;
  OnSubbmit({required this.room});
}
