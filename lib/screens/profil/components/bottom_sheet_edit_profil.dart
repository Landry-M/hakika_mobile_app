import 'package:flutter/material.dart';
import 'package:hakika/provider/authentication_provider.dart';
import 'package:hakika/provider/details_screen_event_provider.dart';
import 'package:provider/provider.dart';

bottomSheetEditProfil(context) {
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
              'Modifier votre profil',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                context.read<AuthenticationProvider>().nameController.text =
                    value!;
              },
              initialValue: context.watch<AuthenticationProvider>().userName,
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
            const SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                context.read<AuthenticationProvider>().emailController.text =
                    value!;
              },
              initialValue: context.watch<AuthenticationProvider>().userEmail,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une valeur valide';
                }
                return null;
              },
              maxLength: 30,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
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

            //phone du user
            const SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                context.read<AuthenticationProvider>().phoneController.text =
                    value!;
              },
              initialValue: context.watch<AuthenticationProvider>().userPhone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une valeur valide';
                }
                return null;
              },
              maxLength: 15,
              decoration: InputDecoration(
                hintText: 'Téléphone',
                prefixIcon: const Icon(Icons.phone),
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
            //mot de passe pour valider changements

            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                context.read<AuthenticationProvider>().passwordController.text =
                    value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer une valeur valide';
                }
                return null;
              },
              maxLength: 30,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                prefixIcon: const Icon(Icons.lock),
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

            const Text(
                'votre mot de passe sert uniquement à valider les changements'),
            const SizedBox(height: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: ElevatedButton(
                onPressed: () {
                  // Action lorsque le bouton est pressé
                  context
                      .read<AuthenticationProvider>()
                      .updateUserInfo(context);
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
                        .watch<AuthenticationProvider>()
                        .isUpdatingUserInfo
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
