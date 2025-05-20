import 'package:flutter/material.dart';
import 'package:hakika/provider/qr_gen_provider.dart';
import 'package:provider/provider.dart';

myBottomSheetForPolice(BuildContext context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    // backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
        children: [
          const Text(
            "Veuillez choisir la police de caractère qui sera appliquer a l'invitation.",
            textAlign: TextAlign.center,
          ),
          //Radio listtile
          RadioListTile(
            title: Text(context.watch<QrGenProvider>().policesList[0]),
            value: context.watch<QrGenProvider>().policesList[0],
            groupValue: context.watch<QrGenProvider>().selectedPolice,
            onChanged: (value) {
              context.read<QrGenProvider>().setPolice(value);
            },
          ),
          RadioListTile(
            title: Text(context.watch<QrGenProvider>().policesList[1]),
            value: context.watch<QrGenProvider>().policesList[1],
            groupValue: context.watch<QrGenProvider>().selectedPolice,
            onChanged: (value) {
              context.read<QrGenProvider>().setPolice(value);
            },
          ),
          RadioListTile(
            title: Text(context.watch<QrGenProvider>().policesList[2]),
            value: context.watch<QrGenProvider>().policesList[2],
            groupValue: context.watch<QrGenProvider>().selectedPolice,
            onChanged: (value) {
              context.read<QrGenProvider>().setPolice(value);
            },
          ),

          const SizedBox(height: 20),
          const Text(
            "Veuillez choisir la taille de police",
            textAlign: TextAlign.center,
          ),
          //Radi
          //Slider
          Slider(
              value: context.watch<QrGenProvider>().selectedPoliceSize,
              min: 10,
              max: 50,
              divisions: 40,
              label: context
                  .watch<QrGenProvider>()
                  .selectedPoliceSize
                  .round()
                  .toString(),
              onChanged: (value) {
                context.read<QrGenProvider>().setPoliceSize(value);
              })
          //
        ],
      ),
    ),
  );
}
