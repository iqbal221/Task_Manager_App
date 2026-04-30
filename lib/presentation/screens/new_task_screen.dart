import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_apps/core/urls.dart';
import 'package:task_manager_apps/data/model/task_status_count_model.dart';
import 'package:task_manager_apps/data/service/api_caller.dart';
import 'package:task_manager_apps/presentation/provider/new_task_list_provider.dart';
import 'package:task_manager_apps/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager_apps/presentation/widgets/snack_bar_message.dart';
import 'package:task_manager_apps/presentation/widgets/task_count_status_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getTaskStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
    context.read<NewTaskListProvider>().getNewTaskList();
  }

  Future<void> _getAllTaskStatusCount() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
    _getTaskStatusCountInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: SizedBox(
                child: Visibility(
                  visible: _getTaskStatusCountInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: GridView.builder(
                    itemCount: _taskStatusCountList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // no scroll inside
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // ✅ 2 columns
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2, // adjust card shape
                    ),
                    itemBuilder: (context, index) {
                      return TaskCountByStatusCard(
                        title: _taskStatusCountList[index].status,
                        count: _taskStatusCountList[index].count,
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<NewTaskListProvider>(
                builder: (context, newTaskListProvider, _) {
                  return Visibility(
                    visible: newTaskListProvider.newTaskListInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ListView.separated(
                      itemCount: newTaskListProvider.newTaskList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: TaskCard(
                            task: newTaskListProvider.newTaskList[index],
                            refreshTaskList: () {
                              context
                                  .read<NewTaskListProvider>()
                                  .getNewTaskList();
                              _getAllTaskStatusCount();
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
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTask,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTask() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
    );
  }
}
