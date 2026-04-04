import 'package:flutter/material.dart';
import 'package:task_manager_apps/core/urls.dart';
import 'package:task_manager_apps/data/model/task_model.dart';
import 'package:task_manager_apps/data/service/api_caller.dart';

class NewTaskListProvider extends ChangeNotifier {
  bool _newTaskListInProgress = false;
  String? _errorMessage;

  bool get newTaskListInProgress => _newTaskListInProgress;
  String? get errorMessage => _errorMessage;

  List<TaskModel> _newTaskList = [];
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;

    _newTaskListInProgress = true;
    notifyListeners();

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
