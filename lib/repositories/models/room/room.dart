import 'package:freezed_annotation/freezed_annotation.dart';
import '../data_model.dart';
part 'room.freezed.dart';
part 'room.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Room extends DataModel with _$Room {
  Room._();
  factory Room({
    required String? id,
    required String? describtion,
    required String name,
    required DateTime dateUpdate,
    required List<String> tasks,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  @override
  String getName() {
    return name;
  }

  @override
  int? getCount() {
    return tasks.length;
  }

  @override
  String? getDescribtion() {
    return describtion;
  }
}
