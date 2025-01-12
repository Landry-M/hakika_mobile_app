import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hakika/api/initialize_appwrite.dart';
import 'package:hakika/models/user_model.dart';
import 'package:hakika/provider/chip_provider.dart';
import 'package:hakika/provider/event_details_provider.dart';
import 'package:hakika/provider/paiement_provider.dart';
import 'package:hakika/provider/user_preferences.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeProvider with ChangeNotifier {
  PageController controller = PageController();
  bool isLoading = false;
  bool noDataFound = false;
  var eventsList = [];
  UserModel userInfo = UserPreferences.getUserInfo();

  createEvent(BuildContext context) {
    isLoading = true;

    notifyListeners();

    final userInfo = UserPreferences.getUserInfo();

    final databases = Databases(InitializeAppwrite().setDefaultParams());
    final eventId = ID.unique();
    final nbInvite =
        Provider.of<EventDetailsProvider>(context, listen: false).nbInviter;

    try {
      final document = databases.createDocument(
          databaseId: '67515e94000ade29c6a3',
          collectionId: '67515ee80019dd4c44c3', //collection events
          documentId: eventId,
          data: {
            "id_organisateur": userInfo.userId,
            "type":
                Provider.of<ChipProvider>(context, listen: false).selectedChip,
            "title": Provider.of<EventDetailsProvider>(context, listen: false)
                .eventTitle,
            "nb_invite": nbInvite,
            "event_date": DateFormat('dd-MM-yyyy H:m').format(
                Provider.of<EventDetailsProvider>(context, listen: false)
                    .selectedDateAndTime),
            "adresse": Provider.of<EventDetailsProvider>(context, listen: false)
                .adresseController
                .value
                .text,
            "salle": Provider.of<EventDetailsProvider>(context, listen: false)
                .salleNameController
                .value
                .text,
          });

      isLoading = false;

      Navigator.pop(context);

      Fluttertoast.showToast(
          msg: "Evénement créé avec succès",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP_LEFT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      isLoading = true;

      //insertion du montant dans la table paiement
      Provider.of<PaiementProvider>(context, listen: false)
          .saveAmountOnServer(eventId, nbInvite.toString(), userInfo.userId);

      notifyListeners();

      Future.delayed(const Duration(seconds: 2), () {
        listOfMyEvent(context);
        isLoading = false;
      });
      //
    } on Exception catch (e) {
      print(e);
    }

    notifyListeners();
  }

  void listOfMyEvent(BuildContext context) async {
    isLoading = true;
    noDataFound = false;

    final databases = Databases(InitializeAppwrite().setDefaultParams());

    // print(userInfo.userId);
    //  print(Provider.of<AuthenticationProvider>(context, listen: false).userRole);

    try {
      final response = await databases.listDocuments(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '67515ee80019dd4c44c3', // collection events
        queries: [
          Query.equal('id_organisateur', userInfo.userId),
          Query.orderDesc('\$createdAt')
        ],
      );

      eventsList = response.documents.map((doc) => doc.data).toList();

      // print(eventsList);

      if (eventsList.isEmpty) {
        noDataFound = true;
      }

      isLoading = false;

      // print(isLoading);
      // print(noDataFound);
      notifyListeners();

      // return response.documents.map((doc) => doc.data).toList();
    } on AppwriteException catch (e) {
      print(e);
      throw Exception('Erreur lors du chargement des documents: $e');
    }
  }

  void listOfMyEventHote(BuildContext context) async {
    isLoading = true;
    noDataFound = false;

    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final doc = await databases.getDocument(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '67515ee80019dd4c44c3', // collection events
        documentId: userInfo.eventId,
      );
      //print(doc.data);
      eventsList = [doc.data];

      if (eventsList.isEmpty) {
        noDataFound = true;
      }

      isLoading = false;

      // print(isLoading);
      // print(noDataFound);
      notifyListeners();

      // return response.documents.map((doc) => doc.data).toList();
    } on Exception catch (e) {
      print(e);
      throw Exception('Erreur lors du chargement des documents: $e');
    }
  }

  getUserPreferences() async {
    final getuserInfo = await UserPreferences.getUserInfo();
    userInfo = getuserInfo;
    notifyListeners();
    return userInfo;
  }
}
