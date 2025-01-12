import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selector_wheel/selector_wheel.dart';

import '../../../provider/chip_provider.dart';
import '../../../provider/event_details_provider.dart';

class EventDetailsBody extends StatelessWidget {
  const EventDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: context.watch<EventDetailsProvider>().formKey,
        child: Column(
          children: [
            Text(
              "Dites nous en plus sur ce(t) ${context.watch<ChipProvider>().selectedChip}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLength: 35,
              onChanged: (value) =>
                  context.read<EventDetailsProvider>().setTitle(value),
              controller: context.watch<EventDetailsProvider>().titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une valeur valide';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Prénoms des hôtes",
                hintText: "Jhon et sophies",
                prefixIcon: const Icon(Icons.title_sharp),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Nombre d'invités"),
            SizedBox(
              width: 200,
              height: 150,
              child: SelectorWheel(
                selectedItemIndex:
                    context.watch<EventDetailsProvider>().nbInviter,
                childCount: 1000,
                // convertIndexToValue is a function that converts the index of the
                // child to a value that is displayed on the selector wheel. In this
                // case, we are converting the index to a string. I.e we'll have
                // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 on the selector wheel.
                convertIndexToValue: (int index) {
                  return SelectorWheelValue(
                    label: index.toString(),
                    value: index,
                    index: index,
                  );
                },
                onValueChanged: (SelectorWheelValue<int> value) {
                  context.read<EventDetailsProvider>().setNbInvite(value.value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
