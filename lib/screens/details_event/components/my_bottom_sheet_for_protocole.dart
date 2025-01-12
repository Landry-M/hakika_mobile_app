import 'package:flutter/material.dart';
import 'package:hakika/provider/details_screen_event_provider.dart';
import 'package:provider/provider.dart';

my_bottom_sheet_for_protocole(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: const  EdgeInsets.all(15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          width: double.infinity,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text(
              'Ajouter un Protocole',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller:
                  context.read<DetailsSreenEventProvider>().protocoleName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une valeur valide';
                }
                return null;
              },
              maxLength: 10,
              decoration: InputDecoration(
                hintText: "Nom",
                prefixIcon: const Icon(Icons.person),
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
            TextFormField(
              keyboardType: TextInputType.number,
              controller:
                  context.read<DetailsSreenEventProvider>().protocolePin,
              //controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une valeur valide';
                }
                return null;
              },
              maxLength: 6,
              decoration: InputDecoration(
                hintText: 'Pin',
                prefixIcon: const Icon(Icons.pin),
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
            SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: ElevatedButton(
                onPressed: () {
                  // Action lorsque le bouton est pressé
                  context
                      .read<DetailsSreenEventProvider>()
                      .createProtocoleAccount(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  //  primary: Colors.blue, // Couleur de fond
                  // onPrimary: Colors.white, // Couleur du texte
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12), // Padding autour du texte
                  shape: RoundedRectangleBorder(
                    // Forme du bouton
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: context
                        .watch<DetailsSreenEventProvider>()
                        .isCreatingProtocole
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white))
                    : const Text(
                        'Approuver',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ]),
        ),
      );
    },
  );
}
