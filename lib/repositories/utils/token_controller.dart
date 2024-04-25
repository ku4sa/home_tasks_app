import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:home_tasks_app/repositories/utils/exception.dart';
import 'package:injectable/injectable.dart';
import 'package:encrypt/encrypt.dart' as encr;
import '../models/token_pair.dart';

@singleton
class TokenController {
  TokenPair? tokens;
  late Box box;
  late encr.Encrypter encrypter;
  final _key = encr.Key.fromBase64('9c5de008640cd6dcb808afeac3f1d315');

  Future<void> init() async {
    encrypter = encr.Encrypter(
      encr.AES(
        _key,
        mode: encr.AESMode.ctr,
        padding: null,
      ),
    );
  }

  Future<void> clearRefreshToken() async {
    box = await Hive.openBox('config');
    await box.clear();
    await box.close();
  }

  Future<void> storeRefreshToken(
    String username,
  ) async {
    box = await Hive.openBox('config');
    final encrypted = encrypter
        .encrypt(
          tokens!.refreshToken,
          iv: encr.IV.fromUtf8('0'),
        )
        .bytes;
    await box.put('refresh_token', encrypted);
    final name = encrypter
        .encrypt(
          username,
          iv: encr.IV.fromUtf8('0'),
        )
        .bytes;
    await box.put('username', name);
    await box.close();
  }

  Future<String?> getLastUserName() async {
    box = await Hive.openBox('config');
    final encrypted = await box.get('username');
    if (encrypted != null) {
      var username = encrypter.decryptBytes(
        encr.Encrypted(encrypted),
        iv: encr.IV.fromUtf8('0'),
      );

      return String.fromCharCodes(username);
    }
    await box.close();
    return null;
  }

  Future<String?> getRefreshToken() async {
    box = await Hive.openBox('config');
    final encrypted = await box.get('refresh_token');
    if (encrypted != null) {
      var token = encrypter.decryptBytes(
        encr.Encrypted(encrypted),
        iv: encr.IV.fromUtf8('0'),
      );

      return String.fromCharCodes(token);
    }
    await box.close();
    return null;
  }

  Future<String?> canFastLogin() async {
    var username = await getLastUserName();
    var token = await getRefreshToken();
    if (username != null && token != null) {
      tokens = TokenPair(token, "");
      return username;
    }
    return null;
  }

  Future<void> refreshToken(Dio dio) async {
    Response? response;
    if (tokens == null) {
      throw AppException(401);
    }
    try {
      response = await dio.post('auth/refresh', queryParameters: {
        'refreshToken': tokens!.refreshToken,
      });
      print('refresh: i asked to change ${tokens?.accessToken}');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        if (tokens == null) {
          tokens = TokenPair(data['refreshToken'], data['accessToken']);
        } else {
          tokens!.accessToken = data['accessToken'];
          tokens!.refreshToken = data['refreshToken'];
        }
        dio.options.headers['Authorization'] = 'Bearer ${tokens!.accessToken}';
      }
      print('refresh: i changed ${tokens?.accessToken}');
    } on DioException catch (error) {
      print(error.response!.statusCode!);
      throw AppException(
        error.response!.statusCode!,
      );
    }
  }
}
