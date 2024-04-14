import 'package:json_annotation/json_annotation.dart';
part 'token_pair.g.dart';

@JsonSerializable()
class TokenPair {
  String refreshToken;
  String accessToken;
  TokenPair(this.refreshToken, this.accessToken);

  factory TokenPair.fromJson(Map<String, dynamic> json) =>
      _$TokenPairFromJson(json);
  Map<String, dynamic> toJson() => _$TokenPairToJson(this);
}
