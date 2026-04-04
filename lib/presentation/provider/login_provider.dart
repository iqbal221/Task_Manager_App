import 'package:flutter/material.dart';
import 'package:task_manager_apps/core/urls.dart';
import 'package:task_manager_apps/data/model/user_model.dart';
import 'package:task_manager_apps/data/service/api_caller.dart';
import 'package:task_manager_apps/presentation/provider/auth_controller.dart';

class LoginProvider extends ChangeNotifier {
  bool _loginInProgress = false;
  String? _errorMessage;

  bool get loginInProgress => _loginInProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> login(Map<String, dynamic> requestBody) async {
    bool isSuccess = false;

    _loginInProgress = true;
    notifyListeners();

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSuccess && response.responseData['status'] == 'success') {
      UserModel userData = UserModel.fromJson(response.responseData["data"]);
      String token = response.responseData["token"];
      await AuthController.saveUserData(userData, token);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _loginInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
