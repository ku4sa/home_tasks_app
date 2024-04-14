import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/navigation/routes.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/view/components/custom_text_field.dart';
import 'package:home_tasks_app/view/components/text_button.dart';

import 'auth_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthorizationPage extends StatelessWidget {
  const AuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Expanded(
          flex: 1,
          child: ClipPath(
            clipper: LeftSideClipper(),
            child: Container(color: AppColors.lightBlue),
          ),
        ),
        Expanded(
          flex: 3,
          child: BlocProvider(
            create: (context) => AuthPageBloc()..add(AuthPageOpened()),
            child: const AuthForm(),
          ),
        ),
      ]),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthPageBloc, AuthPageState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("УСПЕШНО")));

          context.go(AppRoute.home.path);
          //context.go(AppRoute.home.path);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text(state.errorMessage ?? "Произошла какая-то ошибка")));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Align(
            alignment: const Alignment(0, -3 / 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const UserNameInput(),
                const PasswordInput(),
                const NameInput(),
                const AuthButton(),
                InkWell(
                  child: BlocBuilder<AuthPageBloc, AuthPageState>(
                    builder: (context, state) => Text(
                      state.view
                          ? "Есть аккаунт? Войти"
                          : "Нет аккаунта? Зарегестрироваться",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    formKey.currentState?.reset();
                    context.read<AuthPageBloc>().add(ChangePageView());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 120,
      child: BlocBuilder<AuthPageBloc, AuthPageState>(
        builder: (context, state) {
          return CustomTextField(
            initialValue: state.password.value,
            isPassword: true,
            obscureText: false,
            label: "Пароль",
            formzInput: state.password,
            icon: 'assets/icons/password.svg',
            hInt: "Пароль не менее 8 симолов",
            suffixIcon: 'assets/icons/eye.svg',
            secondSuffixIcon: 'assets/icons/close_eye.svg',
            onChanged: (value) {
              context
                  .read<AuthPageBloc>()
                  .add(PasswordChanged(password: value));
            },
          );
        },
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isValid = context.select((AuthPageBloc bloc) => bloc.state.isValid);
    return BlocBuilder<AuthPageBloc, AuthPageState>(
      builder: (context, state) => state.status.isInProgress
          ? const CircularProgressIndicator()
          : MyTextButton(
              onPressed: isValid
                  ? () => context.read<AuthPageBloc>().add(TryAuthorization())
                  : null,
              text: state.view ? "Регистрация" : "Войти",
            ),
    );
  }
}

class UserNameInput extends StatelessWidget {
  const UserNameInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        height: 120,
        child: BlocBuilder<AuthPageBloc, AuthPageState>(
          builder: (context, state) {
            return BlocBuilder<AuthPageBloc, AuthPageState>(
              builder: (context, state) {
                return CustomTextField(
                  initialValue: state.username.value,
                  obscureText: false,
                  label: "Имя пользователя",
                  formzInput: state.username,
                  hInt: "Пароль не менее 1 символа",
                  icon: 'assets/icons/user.svg',
                  suffixIcon: 'assets/icons/clear.svg',
                  onChanged: (value) {
                    context
                        .read<AuthPageBloc>()
                        .add(UsernameChanged(username: value));
                  },
                );
              },
            );
          },
        ));
  }
}

class NameInput extends StatelessWidget {
  const NameInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400,
        height: 120,
        child: BlocBuilder<AuthPageBloc, AuthPageState>(
          builder: (context, state) {
            if (state.view) {
              return CustomTextField(
                initialValue: state.name.value,
                obscureText: false,
                label: "Настоящее имя",
                formzInput: state.name,
                hInt: "Введите свое имя",
                icon: 'assets/icons/user.svg',
                suffixIcon: 'assets/icons/clear.svg',
                onChanged: (value) {
                  context.read<AuthPageBloc>().add(NameChanged(name: value));
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ));
  }
}

class LeftSideClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..cubicTo(size.width / 4, size.height * 2 / 3, size.width,
          size.height / 2, size.width / 2, size.height / 2)
      ..quadraticBezierTo(size.width, size.height * 1 / 3, size.width, 0)
      ..lineTo(0, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
