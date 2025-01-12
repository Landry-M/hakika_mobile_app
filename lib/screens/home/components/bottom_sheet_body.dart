import 'package:flutter/material.dart';
import 'package:hakika/provider/chip_provider.dart';
import 'package:provider/provider.dart';

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({super.key});

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  List<String> chips = ["mariage", "réunion", "anniversaire", "autre"];
  int? value = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Text(
            "Quel genre d'événement organisez-vous?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 5.0,
            runSpacing: 9.0,
            children: List<Widget>.generate(
              4,
              (int index) {
                return ChoiceChip(
                  label: Text(chips[index]),
                  selected: value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      //  print(selected);
                      //print(index);
                      value = selected ? index : null;
                    });
                    context
                        .read<ChipProvider>()
                        .handleSelectedChip(chips[index]);
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
