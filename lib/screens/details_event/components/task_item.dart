import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/task_provider.dart';

class TaskItem extends StatelessWidget {
  final String taskId;
  final String title;
  final bool isCompleted;

  const TaskItem(
      {Key? key,
      required this.title,
      required this.isCompleted,
      required this.taskId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: isCompleted,
      onChanged: (bool? value) {
        if (value != null) {
          print(value);
          print(taskId);
          context.read<TaskProvider>().toggleTask(context, taskId, value);
        }
      },
    );
  }
}
