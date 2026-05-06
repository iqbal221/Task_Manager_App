import 'package:flutter/material.dart';
import 'package:task_pilot/core/urls.dart';
import 'package:task_pilot/data/model/task_model.dart';
import 'package:task_pilot/data/service/api_caller.dart';
import 'package:task_pilot/presentation/provider/auth_controller.dart';

class NewTaskListProvider extends ChangeNotifier {
  bool _newTaskListInProgress = false;
  String? _errorMessage;

  bool get newTaskListInProgress => _newTaskListInProgress;
  String? get errorMessage => _errorMessage;

  List<TaskModel> _newTaskList = [];
  List<TaskModel> get newTaskList => _newTaskList;

  // Future<bool> getNewTaskList() async {
  //   bool isSuccess = false;

  //   _newTaskListInProgress = true;
  //   notifyListeners();

  //   await AuthController.getUserData(); // ✅ Load user data on init
  //   String accessToken = AuthController.accessToken!;
  //   Map<String, String> headers = {"Content-Type": "application/json"};

  //   if (accessToken != null) {
  //     headers["Authorization"] = "Bearer $accessToken";
  //   }

  //   final ApiResponse response = await ApiCaller.getRequest(
  //     url: Urls.newTaskListUrl,
  //     headers: headers,
  //   );

  //   if (response.isSuccess && response.responseData != null) {
  //     List<TaskModel> list = [];
  //     for (Map<String, dynamic> item in response.responseData["data"]) {
  //       list.add(TaskModel.fromJson(item));
  //     }
  //     _newTaskList = list;
  //     isSuccess = true;
  //   } else {
  //     _errorMessage = response.errorMessage;
  //   }

  //   _newTaskListInProgress = false;
  //   notifyListeners();

  //   return isSuccess;
  // }

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;

    _newTaskListInProgress = true;
    notifyListeners();

    await AuthController.getUserData();

    String? accessToken = AuthController.accessToken;
    if (accessToken == null) {
      _errorMessage = "User not logged in";
      _newTaskListInProgress = false;
      notifyListeners();
      return false;
    }

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.newTaskListUrl,
    );

    if (response.isSuccess && response.responseData != null) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> item in response.responseData["data"]) {
        list.add(TaskModel.fromJson(item));
      }

      _newTaskList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _newTaskListInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
