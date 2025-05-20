import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/my_button.dart';

class UpdateRequiredScreen extends StatelessWidget {
  const UpdateRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.system_update,
                  size: 100, color: Colors.blueAccent),
              const SizedBox(height: 32),
              const Text(
                'Mise à jour requise',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Pour continuer à utiliser Hakika, veuillez effectuer la mise à jour vers la dernière version.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              InkWell(
                onTap: () async {
                  const url =
                      'https://play.google.com/store/apps/details?id=events.hakika.hakika'; // Remplacez par le vrai lien
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: myButton(context, 190.0, "Mettre à jour"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
