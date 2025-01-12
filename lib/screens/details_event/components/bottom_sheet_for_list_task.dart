import 'package:flutter/material.dart';
import 'package:hakika/screens/details_event/components/task_list_widget.dart';

bottomSheetForListTasks(BuildContext context, String eventId) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(16),
      child: taskListWidget(context, eventId),
    ),
  );
}
