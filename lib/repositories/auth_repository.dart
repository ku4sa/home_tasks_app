// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:home_tasks_app/repositories/utils/dio.dart';
import 'package:home_tasks_app/repositories/utils/token_controller.dart';
import 'package:injectable/injectable.dart';
import 'models/User.dart';
import 'models/token_pair.dart';
import 'utils/exception.dart';

//TODO:удалить пользователя, выйти, получить инфу о пользователе

@singleton
@injectable
class AuthorizationRepository {
  late final MyDio _dio;
  late final TokenController tokenController;
  ValueNotifier<User?> activeUser = ValueNotifier(null);

  AuthorizationRepository(
    @injectable this._dio,
    @injectable this.tokenController,
  );

  bool isUserAuthorized() {
    print(activeUser.value?.username);
    return activeUser.value != null;
  }

  Future<void> init() async {
    try {
      await tokenController.init();
      await _dio.init(tokenController);

      var lastUser = await tokenController.canFastLogin();
      if (lastUser != null) {
        await fastLogIn();
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> signUp(String username, String password, {String? name}) async {
    Response? response;
    try {
      response = await _dio.dio.post('auth/signUp', queryParameters: {
        'username': username,
        'password': password,
        "name": name,
      });
      if (response.statusCode != 200) {
        var result = response.data as String;
        throw AppException(response.statusCode!, message: result);
      }
    } on DioException catch (error) {
      throw AppException(error.response!.statusCode!,
          message: error.response!.data as String);
    }
  }

  Future<void> logIn(
    String username,
    String password,
  ) async {
    Response? response;
    try {
      response = await _dio.dio.post('auth/logIn', queryParameters: {
        'username': username,
        'password': password,
      });
      //print(response);
      if (response.statusCode != 200) {
        var result = response.data as String;
        throw AppException(response.statusCode!, message: result);
      } else {
        Map<String, dynamic> data = response.data;
        if (tokenController.tokens == null) {
          tokenController.tokens =
              TokenPair(data['refreshToken'], data['accessToken']);
        } else {
          tokenController.tokens!.accessToken = data['accessToken'];
          tokenController.tokens!.refreshToken = data['refreshToken'];
        }
        _dio.dio.options.headers['authorization'] =
            'Bearer ${tokenController.tokens!.accessToken}';
        print(tokenController.tokens!.accessToken);
        activeUser = ValueNotifier(
          User(username: username, name: "", password: password),
        );
        await tokenController.storeRefreshToken(username);
      }
    } on DioException catch (error) {
      throw AppException(error.response!.statusCode!,
          message: error.response!.data as String);
    } catch (error) {
      print(error);
    }
  }

  Future<String?> fastLogIn() async {
    var lastUser = await tokenController.canFastLogin();
    if (lastUser != null) {
      try {
        await tokenController.refreshToken(_dio.dio); //получаем оба токена
        activeUser.value = User(username: lastUser, password: "", name: "");
        return activeUser.value!.name;
      } catch (error) {
        if (error is AppException) {
          return null;
        }
      }
      return null;
    }
    return null;
  }

  Future<void> logOut() async {
    if (tokenController.tokens == null) {
      throw AppException(401); //Человек не зашёл)
    }
    try {
      await _dio.dio.delete('auth/logOut');
      tokenController.tokens = null;
      tokenController.clearRefreshToken();
      activeUser.value = null;
    } on DioException catch (error) {
      throw AppException(
        error.response!.statusCode!,
        message: error.response?.data is String
            ? error.response?.data as String
            : null,
      );
    }
  }

/*
  Future<void> deleteUser() async {
    try {
      await _dio!.delete('auth/deleteuser', data: {
        'nickname': _user.name,
        'password': _user.password,
      });
      _tokenController.tokens = null;
    } on DioException catch (error) {
      print(error);
      throw AuthException(error.response!.statusCode!);
    }
  }
}


  Future<String?> fastLogIn(String username) async {

      try {
        await tokenController.refreshToken(_dio); //получаем оба токена

        activeUser.value =
            User(username: username, password: "", name: "");
       
       
        _server = AuthRemoteDataProvider(
          activeUser.value!,
          _dio,
          tokenController,
        );
        return activeUser.value!.name;
      } catch (error) {
        if (error is AuthException) {
          return null;
        }
      }
    }
    return null;
  }

  Future<AuthStatus> signUp(User user) async {
    _server = AuthRemoteDataProvider(
      user,
      dio,
      tokenController,
    );
    try {
      await _server!.signUp();
    } catch (error) {
      if (error is AuthException) {
        if (error.statusCode == 400) {
          return AuthStatus.invailidData;
        } else if (error.statusCode == 403) {
          return AuthStatus.userExist;
        }
      } else {
        if (kDebugMode) {
          print(error);
        }
        return AuthStatus.globalError;
      }
    }
    return AuthStatus.success;
  }

  Future<AuthStatus> logIn(User user) async {
    _server = AuthRemoteDataProvider(
      user,
      dio,
      tokenController,
    );
    try {
      await _server!.logIn();
      activeUser.value = User(
        name: user.name,
        password: user.password,
      );
    } catch (error) {
      _server = null;
      if (error is AuthException) {
        if (error.statusCode == 400) {
          return AuthStatus.invailidData;
        } else if (error.statusCode == 403) {
          return AuthStatus.invalidLoginorPassword;
        }
      } else {
        if (kDebugMode) {
          print(error);
        }
        return AuthStatus.globalError;
      }
    }

    await storeRefreshToken(
      tokenController.tokens!.refreshToken,
      activeUser.value!.name,
    );

    return AuthStatus.success;
  }

  Future<bool> logOut() async {
    try {
      _server = AuthRemoteDataProvider(
        activeUser.value!,
        dio,
        tokenController,
      );
      activeUser.value = null;
      await _server!.logOut();
      await clearRefreshToken();
      return true;
    } catch (error) {
      if (error is AuthException) {}
      if (kDebugMode) {
        print('Что-то пошло не так при поытке выхода');
      }
      return false;
    }
  }

  Future<String> changePassword(String password, String newPassword) async {
    try {
      await _server!.changePassword(newPassword, password);
    } catch (error) {
      if (error is AuthException) {
        if (error.statusCode == 400) {
          return SLocale.current.wrongInputData;
        } else if (error.statusCode == 403) {
          return SLocale.current.incorrectPassword;
        }
      } else {
        if (kDebugMode) {
          print(error);
        }
        return SLocale.current.globalError;
      }
    }
    return SLocale.current.passwordChangedSuccessfully;
  }
}

enum AuthStatus {
  success('Авторизация прошла успешно!'),
  userExist('Пользователь с таким никнеймом уже существует'),
  invailidData('Некорректные данные'),
  invalidLoginorPassword(
      'Пользователь с таким никнеймом не существует или неверный пароль'),
  globalError('Что-то пошло не так'),
  ;

  const AuthStatus(this.message);
  final String message;
}*/
}

enum AuthStatus {
  success('Авторизация прошла успешно!'),
  userExist('Пользователь с таким никнеймом уже существует'),
  invailidData('Некорректные данные'),
  invalidLoginorPassword(
      'Пользователь с таким никнеймом не существует или неверный пароль'),
  globalError('Что-то пошло не так'),
  ;

  const AuthStatus(this.message);
  final String message;
}
