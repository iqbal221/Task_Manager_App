import 'package:flutter/material.dart';
import 'package:task_manager_apps/app.dart';
import 'package:task_manager_apps/presentation/provider/auth_controller.dart';

void main() async {
  // await AuthController.getUserData(); // 🔥 load token before app starts
  runApp(const TaskManagerApp());
}
