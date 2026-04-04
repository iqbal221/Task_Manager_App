import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_apps/presentation/provider/new_task_list_provider.dart';
import 'package:task_manager_apps/presentation/screens/add_new_task_screen.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();

    context.read<NewTaskListProvider>().getNewTaskList();
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
                    visible: newTaskListProvider.newTaskListInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: ListView.separated(
                      itemCount: newTaskListProvider.newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          task: newTaskListProvider.newTaskList[index],
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
