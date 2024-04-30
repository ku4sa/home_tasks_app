// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import '../data_model.dart';
part 'group_of_rooms.freezed.dart';
part 'group_of_rooms.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class GroupOfRooms extends DataModel with _$GroupOfRooms {
  GroupOfRooms._();
  factory GroupOfRooms({
    required String? id,
    required String author,
    required String? describtion,
    required String name,
    required DateTime dateUpdate,
    required List<String> users,
    required List<String> rooms,
  }) = _GroupOfRooms;

  factory GroupOfRooms.fromJson(Map<String, dynamic> json) =>
      _$GroupOfRoomsFromJson(json);

  @override
  String getName() {
    return name;
  }

  @override
  int? getCount() {
    return rooms.length;
  }

  @override
  String? getDescribtion() {
    return describtion;
  }
}
