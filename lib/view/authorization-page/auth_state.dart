import 'package:formz/formz.dart';

import 'models/models.dart';

final class AuthPageState {
  final bool view;
  final Username username;
  final Password password;
  final Name name;
  final bool isValid;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  const AuthPageState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.name = const Name.pure(),
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.view = true,
    this.errorMessage,
  });

  AuthPageState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    Name? name,
    bool? view,
    bool? isValid,
    String? errorMessage,
  }) {
    return AuthPageState(
      name: name ?? this.name,
      view: view ?? this.view,
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
