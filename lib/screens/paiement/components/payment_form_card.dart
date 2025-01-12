import 'package:flutter/material.dart';
import 'package:hakika/provider/paiement_provider.dart';
import 'package:hakika/screens/widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import 'package:u_credit_card/u_credit_card.dart';

class PaymentFormCard extends StatelessWidget {
  const PaymentFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CreditCardUi(
          cardHolderFullName: context
              .watch<PaiementProvider>()
              .cardHolderFullNameController
              .text,
          cardNumber:
              context.watch<PaiementProvider>().cardNumberController.text,
          validThru:
              context.watch<PaiementProvider>().expiryDateController.text,
          cvvNumber: context.watch<PaiementProvider>().cvvController.text,
        ),
        const SizedBox(height: 20),
        myTextFormField(
          'Numéro de carte',
          Icons.credit_card,
          context.watch<PaiementProvider>().cardNumberController,
          context,
        ),
        const SizedBox(height: 10),
        myTextFormField(
          'Nom du titulaire',
          Icons.person,
          context.watch<PaiementProvider>().cardHolderFullNameController,
          context,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.calendar_month,
              color: context.watch<PaiementProvider>().paymentMethod == 'card'
                  ? Colors.white
                  : Colors.black,
            ),
            label: Text(
              'Date d\'expiration',
              style: TextStyle(
                  color:
                      context.watch<PaiementProvider>().paymentMethod == 'card'
                          ? Colors.white
                          : Colors.black),
            ),
            onPressed: () {
              // Action lorsque le bouton est pressé

              context.read<PaiementProvider>().selectDate(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  context.watch<PaiementProvider>().paymentMethod == 'card'
                      ? const Color.fromARGB(255, 82, 20, 148)
                      : Colors.grey[200],
              //  primary: Colors.blue, // Couleur de fond
              // onPrimary: Colors.white, // Couleur du texte
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 12), // Padding autour du texte
              shape: RoundedRectangleBorder(
                // Forme du bouton
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        myTextFormField(
          'CVV',
          Icons.credit_card,
          context.watch<PaiementProvider>().cvvController,
          context,
        ),
        const SizedBox(height: 10),

       
      ],
    );
  }
}
