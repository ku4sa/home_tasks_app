
import '../../repositories/models/task/task.dart';

abstract class TaskPageEvent {}

final class TaskPageOpened extends TaskPageEvent {}

final class PageUpdated extends TaskPageEvent {}

final class AddTask extends TaskPageEvent {
  final Task task;
  AddTask({required this.task});
}

final class DeleteTask extends TaskPageEvent {
  final Task task;
  DeleteTask({required this.task});
}

final class EditTask extends TaskPageEvent {
  final Task task;
  EditTask({required this.task});
}

final class SearchTask extends TaskPageEvent {
  final String value;
  SearchTask({required this.value});
}
