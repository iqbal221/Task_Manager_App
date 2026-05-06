import 'package:flutter/material.dart';
import 'package:task_pilot/core/urls.dart';
import 'package:task_pilot/data/model/task_model.dart';
import 'package:task_pilot/data/service/api_caller.dart';
import 'package:task_pilot/presentation/provider/auth_controller.dart';
import 'package:task_pilot/presentation/widgets/data_format.dart';
import 'package:task_pilot/presentation/widgets/snack_bar_message.dart';
import 'package:task_pilot/presentation/widgets/status_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.refreshTaskList,
  });

  final TaskModel task;
  final VoidCallback refreshTaskList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _deleteInProgress = false;
  bool _changeStatusInProgress = false;

  @override
  Widget build(BuildContext context) {
    final statusColor = StatusColors.getStatusColor(widget.task.status);

    return SizedBox(
      height: 205,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.zero,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                widget.task.description,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                formatDate(widget.task.createdAt),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),

              Row(
                children: [
                  Chip(
                    label: Text(
                      widget.task.status,
                      style: const TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: statusColor), // ✅ border color
                    ),
                    backgroundColor: statusColor, // ✅ same color
                  ),
                  Spacer(),
                  Visibility(
                    visible: _changeStatusInProgress == false,
                    replacement: CircularProgressIndicator(),
                    child: IconButton(
                      onPressed: () {
                        _showChangeStatusDialog();
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.grey,
                    ),
                  ),
                  Visibility(
                    visible: _deleteInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: IconButton(
                      onPressed: _deleteTask,
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangeStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  _changeStatus('New');
                },
                title: Text('New'),
                trailing: widget.task.status == 'New' ? Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  _changeStatus('Progress');
                },
                title: Text('Progress'),
                trailing: widget.task.status == 'Progress'
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () {
                  _changeStatus('Cancelled');
                },
                title: Text('Cancelled'),
                trailing: widget.task.status == 'Cancelled'
                    ? Icon(Icons.done)
                    : null,
              ),
              ListTile(
                onTap: () {
                  _changeStatus('Completed');
                },
                title: Text('Completed'),
                trailing: widget.task.status == 'Completed'
                    ? Icon(Icons.done)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _changeStatus(String status) async {
    if (status == widget.task.status) return;

    Navigator.pop(context);

    _changeStatusInProgress = true;
    setState(() {});

    await AuthController.getUserData();
    String? accessToken = AuthController.accessToken;

    if (accessToken == null) {
      showSnackBarMessage(context, "User not logged in");
      _changeStatusInProgress = false;
      setState(() {});
      return;
    }

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.updateTaskStatusUrl(widget.task.id, status),
      // headers: {
      //   "Content-Type": "application/json",
      //   "Authorization": "Bearer $accessToken", // ✅ important
      // },
    );

    _changeStatusInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      widget.refreshTaskList();
    } else {
      showSnackBarMessage(
        context,
        response.errorMessage ?? "Failed to update status",
      );
    }
  }

  void _deleteTask() async {
    _deleteInProgress = true;
    setState(() {});

    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.deleteTaskUrl(widget.task.id),
    );

    _deleteInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      widget.refreshTaskList();
      showSnackBarMessage(context, "Task Deleted Successfully");
    } else {
      showSnackBarMessage(
        context,
        response.errorMessage ?? "Failed to delete task",
      );
    }
  }
}
