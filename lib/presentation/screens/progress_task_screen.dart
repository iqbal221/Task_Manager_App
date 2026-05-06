import 'package:flutter/material.dart';

import 'package:task_pilot/core/urls.dart';
import 'package:task_pilot/data/model/task_model.dart';
import 'package:task_pilot/data/service/api_caller.dart';

import 'package:task_pilot/presentation/widgets/empty_task.dart';
import 'package:task_pilot/presentation/widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  List<TaskModel> _progressTaskList = [];
  bool _getProgressTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getAllProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: _getProgressTaskInProgress
                  ? Center(child: CircularProgressIndicator())
                  : _progressTaskList.isEmpty
                  ? EmptyTask()
                  : ListView.separated(
                      itemCount: _progressTaskList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8,
                          ),
                          child: TaskCard(
                            task: _progressTaskList[index],
                            refreshTaskList: () {
                              _getAllProgressTasks();
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 2);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getAllProgressTasks() async {
    _getProgressTaskInProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.progressTaskListUrl,
    );

    if (response.isSuccess &&
        response.responseData != null &&
        response.responseData['data'] != null) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _progressTaskList = list;
    } else {
      showSnackBarMessage(
        context,
        response.errorMessage ?? "Failed to load tasks",
      );
    }

    _getProgressTaskInProgress = false;
    setState(() {});
  }
}
