import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_apps/presentation/provider/login_provider.dart';
import 'package:task_manager_apps/presentation/provider/new_task_list_provider.dart';
import 'package:task_manager_apps/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager_apps/presentation/screens/login_screen.dart';
import 'package:task_manager_apps/presentation/screens/main_nav_bar_screen.dart';
import 'package:task_manager_apps/presentation/screens/sign_up_screen.dart';
import 'package:task_manager_apps/presentation/screens/splash_screen.dart';
import 'package:task_manager_apps/presentation/screens/update_profile_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => NewTaskListProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigator,
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.green,
              fixedSize: Size.fromWidth(double.maxFinite),
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        initialRoute: LoginScreen.name,
        routes: {
          SplashScreen.name: (_) => SplashScreen(),
          MainNavBarScreen.name: (_) => MainNavBarScreen(),
          LoginScreen.name: (_) => LoginScreen(),
          SignUpScreen.name: (_) => SignUpScreen(),
          AddNewTaskScreen.name: (_) => AddNewTaskScreen(),
          UpdateProfileScreen.name: (_) => UpdateProfileScreen(),
        },
      ),
    );
  }
}
