import 'package:flutter/material.dart';
import 'package:task_pilot/core/urls.dart';
import 'package:task_pilot/data/model/task_model.dart';
import 'package:task_pilot/data/service/api_caller.dart';
import 'package:task_pilot/presentation/widgets/empty_task.dart';
import 'package:task_pilot/presentation/widgets/snack_bar_message.dart';
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
              child: _getCancelledTaskInProgress
                  ? Center(child: CircularProgressIndicator())
                  : _cancelledTaskList.isEmpty
                  ? EmptyTask()
                  : ListView.separated(
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
