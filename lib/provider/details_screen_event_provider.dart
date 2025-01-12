import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hakika/provider/home_provider.dart';
import 'package:hakika/provider/user_preferences.dart';
import 'package:provider/provider.dart';

import '../api/initialize_appwrite.dart';

class DetailsSreenEventProvider with ChangeNotifier {
  late var stream;
  String filteredInvitesBy = 'nom';
  List<Map<String, dynamic>> inviterListe = [];
  late List<Map<String, dynamic>> inviterPresents;
  late List<Map<String, dynamic>> inviterAbsents;
  List<Map<String, dynamic>> listProtocole = [];
  List<Map<String, dynamic>> listHotes = [];
  List<Map<String, dynamic>> listInviter = [];
  List<Map<String, dynamic>> filteredInvites = [];
  bool isLoading = true;
  bool isCreatingProtocole = false;
  bool isCreatingHote = false;
  bool isCreatingTask = false;
  var tasksList = [];
  var eventDetails;
  String eventType = '';
  String eventTitle = '';
  int nbTotalInviter = 0;
  var percentagePerson;
  final protocoleName = TextEditingController();
  final protocolePin = TextEditingController();
  final hoteName = TextEditingController();
  final hotePin = TextEditingController();
  final hoteType = TextEditingController();
  // final hote1 = TextEditingController();
  // final hote2 = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  DateTime? taskDueDate;
  String? selectedAssigneeId;
  bool isEventPayed = false;

  createProtocoleAccount(context) async {
    isCreatingProtocole = true;

    notifyListeners();

    final databases = Databases(InitializeAppwrite().setDefaultParams());

    // Vérifier d'abord si un hôte avec le même nom existe déjà pour cet événement
    final existingHotes = await databases.listDocuments(
      databaseId: '67515e94000ade29c6a3',
      collectionId: '6753d82500233a49ef4d', // collection protocile
      queries: [
        Query.equal('event_id', eventDetails['\$id']),
        Query.equal('nom', protocoleName.value.text),
      ],
    );

    if (existingHotes.documents.isNotEmpty) {
      isCreatingProtocole = false;
      notifyListeners();
      // Un hôte avec ce nom existe déjà
      Fluttertoast.showToast(
          msg: 'Un Protocole avec ce nom existe déjà pour cet événement',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: const Color.fromARGB(255, 231, 65, 121),
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    try {
      final response = await databases.createDocument(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '6753d82500233a49ef4d', // collection protocole
        documentId: ID.unique(),
        data: {
          'nom': protocoleName.value.text,
          'pin': int.parse(protocolePin.value.text),
          'event_id': eventDetails['\$id'],
        },
      );

      protocoleName.clear();
      protocolePin.clear();

      getListProtocoles(eventDetails['\$id']);

      notifyListeners();

      Fluttertoast.showToast(
          msg: 'Protocole crée avec succes.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: const Color.fromARGB(255, 231, 65, 121),
          textColor: Colors.white,
          fontSize: 16.0);
    }

    isCreatingProtocole = false;
    notifyListeners();
  }

  Future<void> createHoteAccount(BuildContext context) async {
    isCreatingHote = true;
    notifyListeners();
    try {
      final databases = Databases(InitializeAppwrite().setDefaultParams());

      // Vérifier d'abord si un hôte avec le même nom existe déjà pour cet événement
      final existingHotes = await databases.listDocuments(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '67638e040014df5c2ed7', // collection hote
        queries: [
          Query.equal('event_id', eventDetails['\$id']),
          Query.equal('nom', hoteName.value.text),
        ],
      );

      if (existingHotes.documents.isNotEmpty) {
        isCreatingHote = false;
        notifyListeners();
        // Un hôte avec ce nom existe déjà
        Fluttertoast.showToast(
            msg: 'Un hôte avec ce nom existe déjà pour cet événement',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: const Color.fromARGB(255, 231, 65, 121),
            textColor: Colors.white,
            fontSize: 16.0);

        hoteName.clear();
        hotePin.clear();
        hoteType.clear();
        return;
      }

      // Si aucun hôte n'existe avec ce nom, créer le nouveau hôte
      final hote = await databases.createDocument(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '67638e040014df5c2ed7',
        documentId: ID.unique(),
        data: {
          'nom': hoteName.value.text,
          'type': hoteType.value.text,
          'event_id': eventDetails['\$id'],
          'pin': int.parse(hotePin.value.text),
        },
      );

      // Notification de succès
      Fluttertoast.showToast(
          msg: 'Hôte créé avec succès',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      // Rafraîchir la liste des hôtes
      await getListHotes(eventDetails['\$id']);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Erreur lors de la création de l\'hôte: ${e.toString()}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: const Color.fromARGB(255, 231, 65, 121),
          textColor: Colors.white,
          fontSize: 16.0);
    }

    hoteName.clear();
    hotePin.clear();
    hoteType.clear();
    isCreatingHote = false;
    notifyListeners();
  }

  Future<void> createTask(BuildContext context) async {
    isCreatingTask = true;
    notifyListeners();

    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      // Création de la tâche dans la base de données
      final response = await databases.createDocument(
        databaseId: '67515e94000ade29c6a3',
        collectionId:
            '6769440e001b3c836b9a', // À remplacer par votre ID de collection
        documentId: ID.unique(),
        data: {
          'titre': taskTitleController.value.text,
          'description': taskDescriptionController.value.text,
          'event_id': eventDetails['\$id'],
        },
      );

      // Notification de succès
      Fluttertoast.showToast(
        msg: 'Tâche créée avec succès',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Réinitialisation des champs
      taskTitleController.clear();
      taskDescriptionController.clear();

      // Rafraîchir la liste des tâches
      await getTasksList(eventDetails['\$id']);
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Erreur lors de la création de la tâche: ${e.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: const Color.fromARGB(255, 231, 65, 121),
        textColor: Colors.white,
      );
    }
    isCreatingTask = false;
    notifyListeners();
  }

  getListProtocoles(String eventId) async {
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final response = await databases.listDocuments(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '6753d82500233a49ef4d', // collection protocole
        queries: [
          Query.equal('event_id', eventId),
        ],
      );

      listProtocole = response.documents.map((doc) => doc.data).toList();

      notifyListeners();

      return listProtocole;

      //return response.documents.map((doc) => print(doc.data)).toList();
    } on AppwriteException catch (e) {
      print(e);
      throw Exception('Erreur lors du chargement des documents: $e');
    } catch (e) {
      print(e);
      throw Exception('Erreur lors du chargement des documents: $e');
    }
  }

  getListHotes(String eventId) async {
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final response = await databases.listDocuments(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '67638e040014df5c2ed7', // collection hotes
        queries: [
          Query.equal('event_id', eventId),
        ],
      );

      listHotes = response.documents.map((doc) => doc.data).toList();

      notifyListeners();

      return listHotes;

      //return response.documents.map((doc) => print(doc.data)).toList();
    } on AppwriteException catch (e) {
      print(e);
      throw Exception('Erreur lors du chargement des documents: $e');
    } catch (e) {
      print(e);
      throw Exception('Erreur lors du chargement des documents: $e');
    }
  }

  getListinviter(String eventId) async {
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final response = await databases.listDocuments(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '6752d76b00091ee32b89', // collection inviter
        queries: [
          Query.equal('event_id', eventId),
        ],
      );

      listInviter = response.documents.map((doc) => doc.data).toList();

      notifyListeners();

      return listInviter;

      //return response.documents.map((doc) => print(doc.data)).toList();
    } on AppwriteException catch (e) {
      print(e);
      throw Exception('Erreur lors du chargement des documents: $e');
    } catch (e) {
      print(e);
      throw Exception('Erreur lors du chargement des documents: $e');
    }
  }

  deleteProtocole(BuildContext context, idProtocole, idEvent) async {
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final response = await databases.deleteDocument(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '6753d82500233a49ef4d', // collection protocole
        documentId: idProtocole,
      );
    } catch (e) {
      print(e);
    }

    listProtocole.removeWhere((element) => element['\$id'] == idProtocole);

    Navigator.pop(context);

    Fluttertoast.showToast(
        msg: 'Protocole supprimé avec succes.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void deleteHote(BuildContext context, idHote, idEvent) async {
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final response = await databases.deleteDocument(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '67638e040014df5c2ed7', // collection hote
        documentId: idHote,
      );
    } catch (e) {
      print(e);
    }

    listHotes.removeWhere((element) => element['\$id'] == idHote);

    Navigator.pop(context);

    Fluttertoast.showToast(
        msg: 'Hôte supprimé avec succes.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  deleteEvent(BuildContext context, eventId) async {
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final response = await databases.deleteDocument(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '67515ee80019dd4c44c3', // collection events
        documentId: eventId,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Suppression faite avec succes."),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);

      context.read<HomeProvider>().listOfMyEvent(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: ${e.toString()}')),
      );
    }
  }

  getnviteInRealTime() async {
    final userInfo = UserPreferences.getUserInfo();

    final realtime = Realtime(InitializeAppwrite().setDefaultParams());

    final subscription = realtime.subscribe([
      'databases.67515e94000ade29c6a3.collections.6752d76b00091ee32b89.documents'
    ]);

    subscription.stream.listen((event) {
      // print(event.events);

      if (event.events.contains(
          'databases.67515e94000ade29c6a3.collections.6752d76b00091ee32b89.documents.*.create')) {
        final userIdInDocument = event.payload['organisateur_id'];

        if (userIdInDocument == userInfo.userId) {
          inviterListe.add(event.payload);
          notifyListeners();
        }
      }

      notifyListeners();
    });
  }

  getInviterListForEvent(eventId) async {
    // print(nbTotalInviter);
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final response = await databases.listDocuments(
          databaseId: '67515e94000ade29c6a3',
          collectionId: '6752d76b00091ee32b89', // collection invite
          queries: [
            Query.equal('event_id', eventId),
            Query.limit(999),
          ]);

      inviterListe = response.documents.map((doc) => doc.data).toList();

      notifyListeners();

      inviterPresents = inviterListe
          .where((element) => element['etat'] == 'present')
          .toList();

      inviterAbsents =
          inviterListe.where((element) => element['etat'] == 'absent').toList();

      percentagePerson = ((inviterPresents.length /
              (inviterPresents.length + inviterAbsents.length)) *
          100);

      percentagePerson.isNaN
          ? percentagePerson = 0
          : percentagePerson = percentagePerson;

      filteredInvites =
          inviterListe.toList(); // Initialisation avec toute la liste
      searchController
          .addListener(() => filterInvites()); // Ajout du listener de recherche

      // print(inviterAbsents.length);

      //recuperation de l'etat si l'event est deja payer ou pas
      final responsePaiement = await databases.listDocuments(
          databaseId: '67515e94000ade29c6a3',
          collectionId: '676947fe0022169e4c9b', // collection paiement
          //documentId: eventId,
          queries: [
            Query.equal('event_id', eventId),
          ]);

      // print(responsePaiement.documents[0].data['status']);

      if (responsePaiement.documents.isEmpty) {
        print('pas de paiement');
        isEventPayed = false;
      } else {
        if (responsePaiement.documents[0].data['status'] == 'not paid') {
          isEventPayed = false;
        } else {
          isEventPayed = true;
        }
      }

      isLoading = false;
      notifyListeners();
      return inviterListe;
    } catch (e) {
      print(e);
    }
  }

  //function to set the filter by
  setFilterBy(String filterBy) {
    filteredInvitesBy = filterBy;
    notifyListeners();
  }

  // Fonction pour filtrer la liste des invités
  void filterInvites() {
    String query = searchController.text
        .toLowerCase(); // Récupère la recherche en minuscules

    filteredInvites = inviterListe
        .where((invite) => invite[filteredInvitesBy]
            .toLowerCase()
            .contains(query)) // Filtrage insensible à la casse
        .toList();

    notifyListeners();
  }

  // getInviterAsbsentsOrPresents(eventId, etat) async {
  //   final databases = Databases(InitializeAppwrite().setDefaultParams());

  //   try {
  //     final response = await databases.listDocuments(
  //         databaseId: '67515e94000ade29c6a3',
  //         collectionId: '6752d76b00091ee32b89', // collection invite
  //         queries: [
  //           Query.equal('event_id', eventId),
  //           Query.equal('etat', etat),
  //           Query.limit(nbTotalInviter),
  //         ]);

  //     inviterListe = response.documents.map((doc) => doc.data).toList();

  //     if (etat == 'absent') {
  //       //inviterListe.add((element) => element['etat'] == 'present');
  //       inviterAbsents = inviterListe
  //           .where((element) => element['etat'] == 'absent')
  //           .toList();
  //     } else if (etat == 'present') {
  //       inviterPresents = inviterListe
  //           .where((element) => element['etat'] == 'present')
  //           .toList();
  //     }

  //     print(inviterAbsents.length);

  //     isLoading = false;
  //     notifyListeners();

  //     return inviterListe;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  getEventDetailsById(eventId) async {
    isLoading = true;

    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      //recuperation des details de l'evenement
      final response = await databases.getDocument(
          databaseId: '67515e94000ade29c6a3',
          collectionId: '67515ee80019dd4c44c3', // collection events
          documentId: eventId);

      eventDetails = response.data;
      eventType = response.data['type'];
      eventTitle = response.data['title'];
      nbTotalInviter = response.data['nb_invite'];

      notifyListeners();

      //recuperation de l'etat si l'event est deja payer ou pas
    } catch (e) {
      print(e);
    }
  }

  checkPresenceInRealTime() async {
    final userInfo = UserPreferences.getUserInfo();

    final realtime = Realtime(InitializeAppwrite().setDefaultParams());

    final subscription = realtime.subscribe([
      'databases.67515e94000ade29c6a3.collections.6752d76b00091ee32b89.documents'
    ]);

    subscription.stream.listen((event) {
      if (event.events.contains(
          'databases.67515e94000ade29c6a3.collections.6752d76b00091ee32b89.documents.*.update')) {
        final userIdInDocument = event.payload['organisateur_id'];

        if (userIdInDocument == userInfo.userId) {
          // inviterListe.add(event.payload);

          // print(event.payload);

          if (event.payload['etat'] == 'present') {
            // print(event.payload);
            inviterAbsents.remove(event.payload);

            inviterPresents.add(event.payload);
          } else if (event.payload['etat'] == 'absent') {
            // print(event.payload);

            inviterPresents.remove(event.payload);

            inviterAbsents.add(event.payload);
          }

          percentagePerson = (inviterPresents.length /
                  (inviterPresents.length + inviterAbsents.length)) *
              100;

          notifyListeners();
        }
      }
    });
  }

  Future<void> getTasksList(String eventId) async {
    final databases = Databases(InitializeAppwrite().setDefaultParams());

    try {
      final response = await databases.listDocuments(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '6769440e001b3c836b9a', // collection des tâches
        queries: [
          Query.equal('event_id', eventId),
        ],
      );

      tasksList = response.documents.map((doc) => doc.data).toList();

      // print(tasksList);

      // Mettre à jour l'état si nécessaire
      notifyListeners();
    } catch (e) {
      print('Erreur lors du chargement des tâches: $e');
      throw Exception('Erreur lors du chargement des tâches: $e');
    }
  }
}
