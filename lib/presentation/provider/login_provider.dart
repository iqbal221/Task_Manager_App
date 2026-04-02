import 'package:flutter/material.dart';
import 'package:task_manager_apps/core/urls.dart';
import 'package:task_manager_apps/data/model/user_model.dart';
import 'package:task_manager_apps/data/service/api_caller.dart';
import 'package:task_manager_apps/presentation/provider/auth_controller.dart';

class LoginProvider extends ChangeNotifier {
  bool _loginInProgess = false;
  String? _errorMessage;

  bool get loginInProgess => _loginInProgess;
  String? get errorMessage => _errorMessage;

  Future<bool> login(Map<String, dynamic> requestBody) async {
    bool isSuccess = false;

    _loginInProgess = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      UserModel userData = UserModel.fromJson(response.responseData["data"]);
      String token = response.responseData["token"];
      await AuthController().saveUserData(userData, token);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _loginInProgess = false;
    notifyListeners();

    return isSuccess;
  }
}
