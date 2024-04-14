import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:home_tasks_app/injectable/injectable.dart';
import 'package:home_tasks_app/repositories/auth_repository.dart';
import 'package:home_tasks_app/repositories/utils/dio.dart';
import 'package:home_tasks_app/view/authorization-page/auth_view.dart';
import "package:path_provider/path_provider.dart" as path;

void main() async {
  configureDependencies();
  final currentPath = await path.getApplicationSupportDirectory();
  Hive.init(currentPath.path);
  await GetIt.instance<AuthorizationRepository>().init();
  //var auth = AuthorizationRepository(GetIt.instance<MyDio>());
  //await auth.init();
  // await auth.signUp("ku4sa", "12345678", name: "НАстя");

  //await auth.logIn("ku4sa", "12345678");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: AuthorizationPage(),
        ),
      ),
    );
  }
}
