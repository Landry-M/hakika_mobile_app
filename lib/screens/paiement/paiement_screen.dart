import 'package:flutter/material.dart';
import 'package:hakika/screens/paiement/components/payment_form_cash.dart';
import 'package:provider/provider.dart';

import '../../provider/paiement_provider.dart';
import 'components/payment_form_card.dart';
import 'components/payment_form_phone.dart';

paiementScreen(String eventId, BuildContext context) {
  return SingleChildScrollView(
      child: Padding(
    padding: const EdgeInsets.all(16.0),
    child:
        Consumer<PaiementProvider>(builder: (context, paiementProvider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Choisissez votre méthode de paiement',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            'Id: $eventId',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // Liste des méthodes de paiement
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //paiement par carte
              SizedBox(
                width: 100,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.credit_card,
                    size: 14,
                    color: context.watch<PaiementProvider>().paymentMethod ==
                            'card'
                        ? Colors.white
                        : Colors.black,
                  ),
                  label: Text(
                    'Carte',
                    style: TextStyle(
                        fontSize: 12,
                        color:
                            context.watch<PaiementProvider>().paymentMethod ==
                                    'card'
                                ? Colors.white
                                : Colors.black),
                  ),
                  onPressed: () {
                    // Action lorsque le bouton est pressé

                    context.read<PaiementProvider>().setPaymentMethod('card');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        context.watch<PaiementProvider>().paymentMethod ==
                                'card'
                            ? const Color.fromARGB(255, 82, 20, 148)
                            : Colors.grey[200],
                    //  primary: Colors.blue, // Couleur de fond
                    // onPrimary: Colors.white, // Couleur du texte
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12), // Padding autour du texte
                    shape: RoundedRectangleBorder(
                      // Forme du bouton
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              //const SizedBox(width: 20),

              //paiement caSH

              SizedBox(
                width: 100,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.attach_money,
                    size: 14,
                    color: context.watch<PaiementProvider>().paymentMethod ==
                            'cash'
                        ? Colors.white
                        : Colors.black,
                  ),
                  label: Text(
                    'Cash',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.watch<PaiementProvider>().paymentMethod ==
                              'cash'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  onPressed: () {
                    // Action lorsque le bouton est pressé

                    context.read<PaiementProvider>().setPaymentMethod('cash');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        context.watch<PaiementProvider>().paymentMethod ==
                                'cash'
                            ? const Color.fromARGB(255, 82, 20, 148)
                            : Colors.grey[200],
                    //  primary: Colors.blue, // Couleur de fond
                    // onPrimary: Colors.white, // Couleur du texte
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12), // Padding autour du texte
                    shape: RoundedRectangleBorder(
                      // Forme du bouton
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //paiement par mobile money
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //cash
              SizedBox(
                width: 160,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.smartphone,
                    size: 14,
                    color: context.watch<PaiementProvider>().paymentMethod ==
                            'phone'
                        ? Colors.white
                        : Colors.black,
                  ),
                  label: Text(
                    'Mobile Money',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.watch<PaiementProvider>().paymentMethod ==
                              'phone'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  onPressed: () {
                    // Action lorsque le bouton est pressé

                    context.read<PaiementProvider>().setPaymentMethod('phone');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        context.watch<PaiementProvider>().paymentMethod ==
                                'phone'
                            ? const Color.fromARGB(255, 82, 20, 148)
                            : Colors.grey[200],
                    //  primary: Colors.blue, // Couleur de fond
                    // onPrimary: Colors.white, // Couleur du texte
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12), // Padding autour du texte
                    shape: RoundedRectangleBorder(
                      // Forme du bouton
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Formulaire de paiement dynamique
          context.watch<PaiementProvider>().paymentMethod == 'card'
              ? const PaymentFormCard()
              : context.watch<PaiementProvider>().paymentMethod == 'phone'
                  ? const PaymentFormPhone()
                  : const PaymentFormCash(),

          const SizedBox(height: 20),

          // SizedBox(
          //   width: MediaQuery.of(context).size.width - 70,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       // Action lorsque le bouton est pressé
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.pink,
          //       //  primary: Colors.blue, // Couleur de fond
          //       // onPrimary: Colors.white, // Couleur du texte
          //       padding: const EdgeInsets.symmetric(
          //           horizontal: 20, vertical: 12), // Padding autour du texte
          //       shape: RoundedRectangleBorder(
          //         // Forme du bouton
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     child: const Text(
          //       'Terminer',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      );
    }),
  ));
}
