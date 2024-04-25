import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:home_tasks_app/injectable/injectable.dart';
import 'package:home_tasks_app/navigation/router.dart';
import 'package:home_tasks_app/repositories/auth_repository.dart';
import "package:path_provider/path_provider.dart" as path;

void main() async {
  configureDependencies();
   WidgetsFlutterBinding.ensureInitialized();
  final currentPath = await path.getApplicationSupportDirectory();
  Hive.init(currentPath.path);
  print('лол');
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
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
