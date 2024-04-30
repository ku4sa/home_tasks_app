import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/navigation/routes.dart';
import 'package:home_tasks_app/repositories/auth_repository.dart';
import 'package:home_tasks_app/view/components/custom_app_bar.dart';

import '../components/text_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: MyAppBar(title: 'Настройки'),
      ),
      body: Column(children: [
        MyTextButton(
          text: 'Выйти',
          onPressed: () async {
            GetIt.instance<AuthorizationRepository>()
                .logOut()
                .then((value) => context.go(AppRoute.auth.path));
          },
        ),
      ]),
    );
  }
}
