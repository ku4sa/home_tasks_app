import 'package:freezed_annotation/freezed_annotation.dart';
import '../data_model.dart';

part 'status.freezed.dart';

@Freezed()
class Status extends DataModel with _$Status {
  Status._();

  factory Status({
    required int status,
  }) = _Status;

  @override
  String getName() {
    switch (status) {
      case 1:
        return "Ожидает выполнения";
      case 2:
        return "Пропущена";
      case 3:
        return "Выполнена";
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
