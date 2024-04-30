import 'package:freezed_annotation/freezed_annotation.dart';
import '../data_model.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@Freezed()
class User extends DataModel with _$User {
  User._();

  factory User({
    required String username,
    String? name,
    String? password,
  }) = _User;

  @override
  String getName() {
    return username;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  int? getCount() {
    return null;
  }

  @override
  String? getDescribtion() {
    return name;
  }
}
