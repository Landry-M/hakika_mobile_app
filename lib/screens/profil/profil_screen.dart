import 'package:flutter/material.dart';
import 'package:hakika/screens/profil/components/bottom_sheet_edit_profil.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication_provider.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 82, 20, 148),
        title: const Text(
          'Mon profil',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.9,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 82, 20, 148),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      'lib/assets/img/hakika2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    context.watch<AuthenticationProvider>().userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3.7,
                right: 30,
                left: 30,
              ),
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 242, 242),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "Email: ${context.watch<AuthenticationProvider>().userEmail}"),
                      Text(
                        "Role: ${context.watch<AuthenticationProvider>().userRole}",
                        style: const TextStyle(),
                      ),
                      Text(
                        "Gsm: ${context.watch<AuthenticationProvider>().userPhone}",
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //   heroTag: 'Modifier profil',
          //   backgroundColor: const Color.fromARGB(255, 82, 20, 148),
          //   onPressed: () {
          //     bottomSheetEditProfil(context);
          //   },
          //   child: const Icon(Icons.edit, color: Colors.white),
          // ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: 'logout',
            backgroundColor: Colors.pink,
            onPressed: () {
              context.read<AuthenticationProvider>().logoutUser(context);
            },
            child: const Icon(Icons.power_settings_new, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
