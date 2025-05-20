import 'package:flutter/material.dart';

class PaymentFormCash extends StatelessWidget {
  const PaymentFormCash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Text(
          'Pour toue paiement en cash, veuillez effectuer un transfert manuel au numero suivant +243977948183 puis nous contacter sur whatsapp en nous envoyant les preuves de paiement ainsi que  l\'id de votre évènement au dessus du présent écran',
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
