import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/utils/exception.dart';

import '../../use_cases/authrorization_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'models/models.dart';

class AuthPageBloc extends Bloc<AuthPageEvent, AuthPageState> {
  AuthPageBloc() : super(const AuthPageState()) {
    on<TryAuthorization>(_tryingAuthorization);

    on<AuthPageOpened>(_authPageOpened);

    on<ChangePageView>(_changePageView);

    /*//on<UsernameUnfocused>(_usernameUnfocused);
    //on<PasswordUnfocused>(_passwordUnfocused);

    on<ChangePasswordVisibility>(_changePasswordVisibility);*/

    on<UsernameChanged>(_usernameChanged);

    on<NameChanged>(_nameChanged);

    on<PasswordChanged>(_passwordChanged);
  }

  late final AuthorizationUseCase _authorizationUseCase;

  /* Future<void> _usernameUnfocused(
      UsernameUnfocused event, Emitter<AuthPageState> emit) async {
    final username = Username.dirty(state.username.value);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([username, state.password]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _passwordUnfocused(
    PasswordUnfocused event,
    Emitter<AuthPageState> emit,
  ) async {
    final password = Password.dirty(state.password.value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.username, password]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _changePasswordVisibility(
    ChangePasswordVisibility event,
    Emitter<AuthPageState> emit,
  ) async {
    emit(
      state.copyWith(
          isPasswordVisible: !state.isPasswordVisible,
          status: FormzSubmissionStatus.initial),
    );
  }*/

  Future<void> _usernameChanged(
      UsernameChanged event, Emitter<AuthPageState> emit) async {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username.isValid ? username : Username.pure(event.username),
        isValid: state.view
            ? Formz.validate([
                username,
                state.password,
                state.name,
              ])
            : Formz.validate([
                username,
                state.password,
              ]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _passwordChanged(
      PasswordChanged event, Emitter<AuthPageState> emit) async {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password.isValid ? password : Password.pure(event.password),
        isValid: state.view
            ? Formz.validate([
                state.username,
                state.name,
                password,
              ])
            : Formz.validate([
                state.username,
                password,
              ]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _nameChanged(
      NameChanged event, Emitter<AuthPageState> emit) async {
    final name = Name.dirty(event.name);
    emit(
      state.copyWith(
        name: state.name.isValid ? name : Name.pure(event.name),
        isValid: state.view
            ? Formz.validate([
                state.username,
                state.password,
                name,
              ])
            : Formz.validate([
                state.username,
                state.password,
              ]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _changePageView(
      ChangePageView event, Emitter<AuthPageState> emit) async {
    emit(
      state.copyWith(
          view: !state.view,
          status: FormzSubmissionStatus.initial,
          name: const Name.pure(""),
          password: const Password.pure(""),
          username: const Username.pure("")),
    );
  }

  Future<void> _authPageOpened(
      AuthPageOpened event, Emitter<AuthPageState> emit) async {
        
    _authorizationUseCase = GetIt.instance<AuthorizationUseCase>();
    await _authorizationUseCase.init();
    emit(
      state.copyWith(
          status: FormzSubmissionStatus.initial,
          name: const Name.pure(""),
          password: const Password.pure(""),
          username: const Username.pure("")),
    );
  }

  Future<void> _tryingAuthorization(
    TryAuthorization event,
    Emitter<AuthPageState> emit,
  ) async {
    final username = Username.dirty(state.username.value);
    final password = Password.dirty(state.password.value);

    final name = Name.dirty(state.name.value);
    emit(
      state.copyWith(
        username: username,
        password: password,
        name: name,
        isValid: Formz.validate([username, password, name]),
        status: FormzSubmissionStatus.initial,
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      if (state.view) {
        try {
          await _authorizationUseCase.signUp(
            state.username.value,
            state.password.value,
            name: state.name.value,
          );
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.success,
            ),
          );
        } catch (error) {
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: (error is AppException)
                  ? error.getMessage()
                  : "Глобальная ошибка",
            ),
          );
        }
      } else {
        try {
          await _authorizationUseCase.logIn(
            state.username.value,
            state.password.value,
          );

          emit(
            state.copyWith(
              status: FormzSubmissionStatus.success,
            ),
          );
        } catch (error) {
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.failure,
              errorMessage: (error is AppException)
                  ? error.getMessage()
                  : "Глобальная ошибка",
            ),
          );
        }
      }
    }
  }
}
