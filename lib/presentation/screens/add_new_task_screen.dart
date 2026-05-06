import 'package:flutter/material.dart';
import 'package:task_pilot/core/urls.dart';
import 'package:task_pilot/data/service/api_caller.dart';
import 'package:task_pilot/presentation/provider/auth_controller.dart';
import 'package:task_pilot/presentation/screens/main_nav_bar_screen.dart';
import 'package:task_pilot/presentation/widgets/screen_background.dart';
import 'package:task_pilot/presentation/widgets/snack_bar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = "/add-new-task";

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text(
                    'Add new task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleTEController,
                    style: const TextStyle(color: Colors.black), // 👈 FIX
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    style: const TextStyle(color: Colors.black), // 👈 FIX
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: FilledButton(
                      onPressed: _onTapAddButton,
                      child: Text('Add', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    // ✅ Load user data first
    await AuthController.getUserData();

    String? accessToken = AuthController.accessToken;

    if (accessToken == null) {
      showSnackBarMessage(context, "User not logged in");
      _addNewTaskInProgress = false;
      setState(() {});
      return;
    }

    // ✅ Access email correctly
    String? email = AuthController.userModel?.email;
    print("User email: $email");

    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
      "email": email ?? '', // ✅ use email from user data
    };

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.addNewTaskUrl,
      body: requestBody,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken", // ✅ important
      },
    );

    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainNavBarScreen.name,
        (predict) => false,
      );
      showSnackBarMessage(context, "Task added successfully!");
    } else {
      showSnackBarMessage(context, "Failed to add task");
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
