import 'package:flutter/material.dart';
import 'package:task_manager_apps/presentation/screens/cancelled_task_screen.dart';
import 'package:task_manager_apps/presentation/screens/completed_task_screen.dart';
import 'package:task_manager_apps/presentation/screens/new_task_screen.dart';
import 'package:task_manager_apps/presentation/screens/progress_task_screen.dart';
import 'package:task_manager_apps/presentation/widgets/tm_appbar.dart';

class MainNavBarScreen extends StatefulWidget {
  const MainNavBarScreen({super.key});

  static const String name = "/dashboard";

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

class _MainNavBarScreenState extends State<MainNavBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CancelledTaskScreen(),
    CompletedTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppbar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: "New",
          ),
          NavigationDestination(icon: Icon(Icons.refresh), label: "Progress"),
          NavigationDestination(icon: Icon(Icons.close), label: "Cancelled"),
          NavigationDestination(icon: Icon(Icons.done), label: "Completed"),
        ],
      ),
    );
  }
}
