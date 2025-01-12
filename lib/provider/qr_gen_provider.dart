import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hakika/models/user_model.dart';
import 'package:hakika/provider/details_screen_event_provider.dart';
import 'package:hakika/provider/user_preferences.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/initialize_appwrite.dart';

class QrGenProvider with ChangeNotifier {
  final inviterNameController = TextEditingController();
  final tableNameController = TextEditingController();
  final commentNameController = TextEditingController();
  bool obscurText = false;
  String qrCodeData = "Hakika";
  GlobalKey globalKey = GlobalKey();
  bool isSending = true;
  var dateMariage;
  var heureMariage;

  String setNewDataInQrCode(data) {
    qrCodeData =
        "${inviterNameController.value.text}. Table:${tableNameController.value.text}. Commentaire: ${commentNameController.value.text}";

    //  print(qrCodeData);
    notifyListeners();

    return '';
  }

  clearController() {
    inviterNameController.clear();
    tableNameController.clear();
    commentNameController.clear();
  }

  sendInviterInfoToServer(String eventId) async {

    
    isSending = true;

    notifyListeners();

    final databases = Databases(InitializeAppwrite().setDefaultParams());

    UserModel userInfo = UserPreferences.getUserInfo();

    try {
      final response = await databases.createDocument(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '6752d76b00091ee32b89', // collection protocole
        documentId: ID.unique(),
        data: {
          'nom': inviterNameController.value.text,
          'event_id': eventId,
          'organisateur_id': userInfo.userId,
          'table': tableNameController.value.text,
          'commentaire': commentNameController.value.text,
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  formaterDateMariage(BuildContext context) {
    var now =
        context.watch<DetailsSreenEventProvider>().eventDetails['event_date'];

    final DateFormat formatter = DateFormat('dd-MM-yyyy H:m');
    final String formatted = formatter.format(DateTime.parse(now));
    print(formatted);
    dateMariage = formatted;
    // heureMariage =
    //notifyListeners();
  }
}
