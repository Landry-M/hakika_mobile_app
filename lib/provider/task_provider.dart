import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hakika/api/initialize_appwrite.dart';

class TaskProvider extends ChangeNotifier {
  final List<dynamic> tasks = [];

  // List<Task> get tasks => _tasks;

  void toggleTask(BuildContext context, taskId, bool isCompleted) {
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    databases.updateDocument(
      databaseId: '67515e94000ade29c6a3',
      collectionId: '6769440e001b3c836b9a',
      documentId: taskId,
      data: {'is_completed': isCompleted},
    );
    // task.isCompleted = !task.isCompleted;

    Fluttertoast.showToast(
        msg: 'Tache mise a jour avec succes.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);

    notifyListeners();
  }

  void addTask(String taskName) {
    tasks.add(taskName);
    notifyListeners();
  }

  void removeTask(String taskId) {
    tasks.remove(taskId);
    notifyListeners();
  }
}
