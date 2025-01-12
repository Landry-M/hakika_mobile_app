import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../api/initialize_appwrite.dart';

class PaiementProvider extends ChangeNotifier {
  String paymentMethod = 'card';
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cardHolderFullNameController =
      TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  var expiryDate = DateTime.now();

  bool isCardValid = false;

  bool isPaid = false;

  // Méthode pour valider le numéro de carte (facultatif)
  void validateCard() {
    // isCardValid = CreditCardValidator.isValid(cardNumberController.text);
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    print(method);
    paymentMethod = method;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    var picked = await showDatePicker(
          context: context,
          initialDate: expiryDate, // Date initiale
          firstDate: DateTime.now(), // Date la plus ancienne
          lastDate: DateTime(2031), // Date la plus récente
        ) ??
        expiryDate;

    expiryDateController.text = DateFormat('MM/yy').format(picked);

  //  print(expiryDateController.text);

    notifyListeners();
  }

  void saveAmountOnServer(
    String eventId,
    String nbInviter,
    String organisateurId,
  ) {
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final document = databases.createDocument(
          databaseId: '67515e94000ade29c6a3',
          collectionId: '676947fe0022169e4c9b', // collection paiement
          documentId: ID.unique(),
          data: {
            "event_id": eventId,
            "nb_inviter": nbInviter,
            "organisateur_id": organisateurId,
          });
      //
    } on Exception catch (e) {
      print(e);
    }
  }
}
