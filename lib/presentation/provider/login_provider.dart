import 'package:flutter/material.dart';
import 'package:task_pilot/core/urls.dart';
import 'package:task_pilot/data/model/user_model.dart';
import 'package:task_pilot/data/service/api_caller.dart';
import 'package:task_pilot/presentation/provider/auth_controller.dart';

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

    if (response.isSuccess) {
      UserModel userData = UserModel.fromJson(response.responseData["data"]);
      String token = response.responseData?["data"]["token"];
      await AuthController.saveUserData(userData, token);
      _errorMessage = null;
      isSuccess = true;
    } else {
      String? message = response.responseData?["message"];
      _errorMessage = message ?? "User not found";
    }

    _loginInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
