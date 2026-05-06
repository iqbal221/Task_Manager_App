import 'package:flutter/material.dart';

import 'package:task_pilot/core/urls.dart';
import 'package:task_pilot/data/model/task_model.dart';
import 'package:task_pilot/data/service/api_caller.dart';
import 'package:task_pilot/presentation/widgets/empty_task.dart';

import 'package:task_pilot/presentation/widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  List<TaskModel> _completedTaskList = [];
  bool __completedTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getAllCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: __completedTaskInProgress
                  ? Center(child: CircularProgressIndicator())
                  : _completedTaskList.isEmpty
                  ? EmptyTask()
                  : ListView.separated(
                      itemCount: _completedTaskList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8,
                          ),
                          child: TaskCard(
                            task: _completedTaskList[index],
                            refreshTaskList: () {
                              _getAllCompletedTasks();
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

  Future<void> _getAllCompletedTasks() async {
    __completedTaskInProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.completedTaskListUrl,
    );

    if (response.isSuccess &&
        response.responseData != null &&
        response.responseData['data'] != null) {
      List<TaskModel> list = [];

      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }

      _completedTaskList = list;
    } else {
      showSnackBarMessage(
        context,
        response.errorMessage ?? "Something went wrong",
      );
    }

    __completedTaskInProgress = false;
    setState(() {});
  }
}
