import 'package:flutter/material.dart';
import 'package:task_manager_apps/data/model/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});

  final TaskModel task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(widget.task.description, style: TextStyle(fontSize: 16)),
              Text(
                widget.task.createdAt,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Row(
                children: [
                  Chip(
                    label: Text(widget.task.status),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    backgroundColor: Colors.blue,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit, color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
