import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_apps/core/urls.dart';
import 'package:task_manager_apps/data/model/task_model.dart';
import 'package:task_manager_apps/data/service/api_caller.dart';
import 'package:task_manager_apps/presentation/provider/new_task_list_provider.dart';
import 'package:task_manager_apps/presentation/widgets/snack_bar_message.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            Expanded(
              child: Consumer<NewTaskListProvider>(
                builder: (context, newTaskListProvider, _) {
                  return Visibility(
                    visible: _getProgressTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ListView.separated(
                      itemCount: _progressTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          task: _progressTaskList[index],
                          refreshTaskList: () {
                            _getAllProgressTasks();
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 2);
                      },
                    ),
                  );
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
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getProgressTaskInProgress = false;
    setState(() {});
  }
}
