import 'package:flutter/material.dart';
import 'package:hakika/screens/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

import '../../../provider/paiement_provider.dart';

class PaymentFormPhone extends StatelessWidget {
  const PaymentFormPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        myTextFormField(
          'Numéro de téléphone',
          Icons.smartphone,
          context.watch<PaiementProvider>().phoneNumberController,
          context,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('lib/assets/icons/airtel2.jpg', width: 90, height: 90),
            Image.asset('lib/assets/icons/mpesa.jpeg', height: 50),
            Image.asset('lib/assets/icons/orange.png', width: 100, height: 100),
          ],
        )
      ],
    );
  }
}
