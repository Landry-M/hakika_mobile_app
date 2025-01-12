import 'package:flutter/material.dart';

class EventDetailsProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController inviteController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();
  final TextEditingController salleNameController = TextEditingController();

  String eventTitle = '';
  int nbInviter = 120;
  var selectedDate = DateTime.now();
  var selectedTime = TimeOfDay.now();
  var selectedDateAndTime = DateTime.now();

  setNbInvite(int nbInvite) {
    nbInviter = nbInvite;
    //print(nbInviter);
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    var picked = await showDatePicker(
          context: context,
          initialDate: selectedDate, // Date initiale
          firstDate: DateTime.now(), // Date la plus ancienne
          lastDate: DateTime(2031), // Date la plus récente
        ) ??
        selectedDate;

    selectedDate = picked;
    selectedDateAndTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );
    notifyListeners();
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute),
    );

    selectedDateAndTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime!.hour,
      selectedTime.minute,
    );

    notifyListeners();
  }

  setTitle(String title) {
    titleController.text = title;
    eventTitle = title;
    notifyListeners();
  }
}
