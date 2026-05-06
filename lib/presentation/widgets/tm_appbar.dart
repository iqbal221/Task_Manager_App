import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_pilot/core/app_colors.dart';
import 'package:task_pilot/presentation/provider/auth_controller.dart';
import 'package:task_pilot/presentation/provider/theme_provider.dart';
import 'package:task_pilot/presentation/screens/login_screen.dart';
import 'package:task_pilot/presentation/screens/update_profile_screen.dart';

class TMAppbar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppbar({super.key});

  @override
  State<TMAppbar> createState() => _TMAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TMAppbarState extends State<TMAppbar> {
  @override
  Widget build(BuildContext context) {
    final photoProfile = AuthController.userModel?.photo ?? '';

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,

          title: GestureDetector(
            onTap: _updateProfile,
            child: Row(
              children: [
                CircleAvatar(
                  child: photoProfile.isNotEmpty
                      ? Image.memory(base64Decode(photoProfile))
                      : const Icon(Icons.person),
                ),
                const SizedBox(width: 8),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AuthController.userModel?.email ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      AuthController.userModel?.fullName ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          actions: [
            IconButton(
              icon: Icon(
                themeProvider.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),

            IconButton(onPressed: _signOut, icon: const Icon(Icons.logout)),
          ],
        );
      },
    );
  }

  void _signOut() {
    AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginScreen.name,
      (predicate) => false,
    );
  }

  void _updateProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
    );
  }
}
