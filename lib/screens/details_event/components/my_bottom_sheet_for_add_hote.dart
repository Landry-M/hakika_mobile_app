import 'package:flutter/material.dart';
import 'package:hakika/provider/details_screen_event_provider.dart';
import 'package:provider/provider.dart';

myBottomSheetForAddHote(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          width: double.infinity,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text(
              'Ajouter un Hôte',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: context.read<DetailsSreenEventProvider>().hoteName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une valeur valide';
                }
                return null;
              },
              maxLength: 15,
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
              controller: context.read<DetailsSreenEventProvider>().hotePin,
              //controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une valeur valide';
                }
                return null;
              },
              maxLength: 8,
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

            //role ou type de l'hote
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: context.read<DetailsSreenEventProvider>().hoteType,
              //controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une valeur valide';
                }
                return null;
              },
              maxLength: 15,
              decoration: InputDecoration(
                hintText: 'role. ex: epoux',
                prefixIcon: const Icon(Icons.type_specimen),
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
                      .createHoteAccount(context);
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
                child: context.watch<DetailsSreenEventProvider>().isCreatingHote
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
