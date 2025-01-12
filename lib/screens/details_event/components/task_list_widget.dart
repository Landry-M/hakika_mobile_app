import 'package:flutter/material.dart';
import 'package:hakika/screens/details_event/components/task_item.dart';
import 'package:provider/provider.dart';

import '../../../provider/details_screen_event_provider.dart';

taskListWidget(BuildContext context, String eventId) {
  //context.read<DetailsSreenEventProvider>().getTasksList(eventId);
  return Consumer<DetailsSreenEventProvider>(
    builder: (context, taskProvider, child) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: taskProvider.tasksList.length,
        itemBuilder: (context, index) {
          final task = taskProvider.tasksList[index];
          return TaskItem(
            title: task['titre'],
            taskId: task['\$id'],
            isCompleted: task['is_completed'],
          );
        },
      );
    },
  );
}
