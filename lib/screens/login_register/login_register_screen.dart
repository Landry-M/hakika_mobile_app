import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/my_button.dart';
import '../widgets/my_button_outline.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 82, 20, 148),
                    image: DecorationImage(
                      image: AssetImage(
                        "lib/assets/img/salomon.jpeg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HAKIKA",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Authentification",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Bienvenu, Veuillez sélectionner l'action correspondante à votre profil",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => context.goNamed('login'),
                      child: myButtonOutline(context, 120.0, "connexion"),
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'ou',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(width: 14),
                    InkWell(
                      onTap: () => context.goNamed('register'),
                      child: myButton(context, 120.0, "inscription"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Mot de passe oublié? "),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        context.goNamed('forgot-password');
                      },
                      child: const Text(
                        "Cliquez ici",
                        style: TextStyle(
                          color: Color.fromARGB(255, 82, 20, 148),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
