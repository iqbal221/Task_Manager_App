import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_apps/core/urls.dart';
import 'package:task_manager_apps/data/model/task_model.dart';
import 'package:task_manager_apps/data/service/api_caller.dart';
import 'package:task_manager_apps/presentation/provider/new_task_list_provider.dart';
import 'package:task_manager_apps/presentation/widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  List<TaskModel> _cancelledTaskList = [];
  bool _getCancelledTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getAllCancelledTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Consumer<NewTaskListProvider>(
                builder: (context, newTaskListProvider, _) {
                  return Visibility(
                    visible: _getCancelledTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ListView.separated(
                      itemCount: _cancelledTaskList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8,
                          ),
                          child: TaskCard(
                            task: _cancelledTaskList[index],
                            refreshTaskList: () {
                              _getAllCancelledTasks();
                            },
                          ),
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

  Future<void> _getAllCancelledTasks() async {
    _getCancelledTaskInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.cancelledTaskListUrl,
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getCancelledTaskInProgress = false;
    setState(() {});
  }
}
