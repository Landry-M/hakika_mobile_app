import 'package:flutter/material.dart';
import 'package:hakika/provider/event_details_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../provider/chip_provider.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            maxLength: 50,
            controller:
                context.watch<EventDetailsProvider>().salleNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer une valeur valide';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText:
                  "Salle de votre ${context.watch<ChipProvider>().selectedChip}",
              hintText:
                  "Salle de votre ${context.watch<ChipProvider>().selectedChip}",
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
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Date choisi: ${DateFormat('dd-MM-yyyy à H:m').format(context.watch<EventDetailsProvider>().selectedDateAndTime)}', // Affiche la date
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => context
                    .read<EventDetailsProvider>()
                    .selectDate(context), // Ouvre le DatePicker
                child: const Text('Choisir une Date'),
              ),
              ElevatedButton(
                onPressed: () => context
                    .read<EventDetailsProvider>()
                    .selectTime(context), // Ouvre le DatePicker
                child: const Text('Choisir une heure'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
