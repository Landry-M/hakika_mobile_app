import 'package:flutter/material.dart';

class ChipProvider with ChangeNotifier {
  List<String> chips = ["mariage", "reunion", "anniversaire", "autre"];
  String selectedChip = '';
  int selectedChipIndex = 5;
  bool nextButtonForChipIsVisible = false;

  handleSelectedChip(String newValue) {
    selectedChip = newValue;
    // print(selectedChip);
    nextButtonForChipIsVisible = true;
    notifyListeners();

    return newValue;
  }
}
