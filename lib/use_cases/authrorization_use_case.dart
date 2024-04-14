import 'package:home_tasks_app/repositories/utils/exception.dart';
import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

@injectable
class AuthorizationUseCase {
  AuthorizationUseCase(
    @injectable this._authRepository,
  );
  late final AuthorizationRepository _authRepository;

  Future<void> init() async {
    await _authRepository.init();
  }

  Future<void> signUp(String username, String password, {String? name}) async {
    try {
      await _authRepository.signUp(username, password, name: name);
      await _authRepository.logIn(username, password);
    } catch (error) {
      if (error is AuthException) {
        print(error.message);
        rethrow;
      }
    }
  }

  Future<void> logIn(String username, String password) async {
    try {
      await _authRepository.logIn(username, password);
    } catch (error) {
      if (error is AuthException) {
        print(error.message);
        rethrow;
      }
    }
  }
}
