import 'package:freezed_annotation/freezed_annotation.dart';
import '../data_model.dart';
part 'task_type.freezed.dart';
part 'task_type.g.dart';

@Freezed()
class TaskType extends DataModel with _$TaskType {
  TaskType._();

  factory TaskType({
    required int type,
  }) = _TaskType;

  @override
  String getName() {
    switch (type) {
      case 1:
        return "Разовая";
      case 2:
        return "Повторяющаяся";

      default:
        return "???";
    }
  }

  @override
  int? getCount() {
    return null;
  }

  @override
  String? getDescribtion() {
    return null;
  }
}
