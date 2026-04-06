import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_apps/presentation/provider/auth_controller.dart';
import 'package:task_manager_apps/presentation/screens/login_screen.dart';
import 'package:task_manager_apps/presentation/screens/update_profile_screen.dart';

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
    final photoProfile = AuthController.userModel!.photo;

    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: _updateProfile,
        child: Row(
          spacing: 8,
          children: [
            CircleAvatar(
              child: photoProfile.isNotEmpty
                  ? Image.memory(jsonDecode(photoProfile))
                  : Icon(Icons.person),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel!.email,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
                Text(
                  AuthController.userModel!.fullName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _signOut();
          },
          icon: Icon(Icons.logout),
        ),
      ],
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
