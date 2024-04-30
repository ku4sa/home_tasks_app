import 'package:home_tasks_app/repositories/models/status/status.dart';
import 'package:home_tasks_app/repositories/models/task_type/task_type.dart';
import 'package:home_tasks_app/repositories/models/user/user.dart';

import '../../repositories/models/task/task.dart';

abstract class TaskEditorEvents {}

final class CreatorOpened extends TaskEditorEvents {}

final class EditorOpened extends TaskEditorEvents {
  final Task task;
  EditorOpened({required this.task});
}

final class ChangeName extends TaskEditorEvents {
  final String name;
  ChangeName({required this.name});
}

final class ChangeTaskType extends TaskEditorEvents {
  final TaskType type;
  ChangeTaskType({required this.type});
}

final class ChangeStatus extends TaskEditorEvents {
  final Status status;
  ChangeStatus({required this.status});
}

final class ChangeLeadTime extends TaskEditorEvents {
  final String time;
  ChangeLeadTime({required this.time});
}

final class ChangePriority extends TaskEditorEvents {
  final int priority;
  ChangePriority({required this.priority});
}

final class ChangeInterval extends TaskEditorEvents {
  final int? interval;
  final int? type;
  ChangeInterval({
    this.interval,
    this.type,
  });
}

final class ChangeDate extends TaskEditorEvents {
  final DateTime time;
  ChangeDate({required this.time});
}

final class ImportSettings extends TaskEditorEvents {
  final Task task;
  ImportSettings({required this.task});
}

final class ChangeDescribtion extends TaskEditorEvents {
  final String describtion;
  ChangeDescribtion({required this.describtion});
}

final class ChangeActiveUser extends TaskEditorEvents {
  final User user;
  ChangeActiveUser({required this.user});
}

final class OnSubbmit extends TaskEditorEvents {
  final Task task;
  OnSubbmit({required this.task});
}
