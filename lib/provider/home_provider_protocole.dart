import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hakika/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../api/initialize_appwrite.dart';

class HomeProviderProtocole with ChangeNotifier {
  var codeQrScanner;
  bool isFlashOn = false;

  Future<void> scanQR(BuildContext context) async {
    // Lance le scanner et récupère le résultat
    String scannedResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Couleur de la barre de scan
      'Annuler', // Texte du bouton "Annuler"
      true, // Afficher la lampe torche (true = oui)
      ScanMode.QR, // Mode de scan QR
    );

    // Si un résultat est scanné, l'afficher
    if (scannedResult != '-1') {
      // Vous pouvez maintenant utiliser le résultat scanné
      List<String> nomInviter = scannedResult.split('.');

      //  print(nomInviter[0]);

      final databases = Databases(InitializeAppwrite().setDefaultParams());

      try {
        final response = await databases.listDocuments(
          databaseId: '67515e94000ade29c6a3',
          collectionId: '6752d76b00091ee32b89', // collection inviter

          queries: [
            Query.equal('nom', nomInviter[0]),
            Query.equal(
              'event_id',
              Provider.of<AuthenticationProvider>(context, listen: false)
                  .eventId,
            ),
          ],
        );

        if (response.documents.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/icons/cross.png',
                    height: 50,
                  )
                ],
              ),
              content: const Text(
                "Ce Code QR n'est pas lié à cet événement",
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          //si on  retrouve les info de l'inviter scanner
          var etatInviter = response.documents[0].data['etat'];
          // var documentId = response.documents[0].data['\$id'];

          if (etatInviter == 'present') {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    const Text("QR déjà scanné"),
                    Image.asset(
                      'lib/assets/icons/cross.png',
                      height: 50,
                    )
                  ],
                ),
                content: Text(scannedResult),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (etatInviter == 'absent') {
            //print(response.documents[0].data['\$id']);

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    const Text("Scan effectué"),
                    Image.asset(
                      'lib/assets/icons/check.png',
                      height: 50,
                    ),
                  ],
                ),
                content: Text(scannedResult),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );

            //
//mise a jour de la presenece de l'inviter lorsque on scan le Qr
            Document result = await databases.updateDocument(
              databaseId: '67515e94000ade29c6a3',
              collectionId: '6752d76b00091ee32b89', // collection inviter
              documentId: response.documents[0].data['\$id'],
              data: {
                'etat': 'present',
                'scaned_by':
                    Provider.of<AuthenticationProvider>(context, listen: false)
                        .userName,
              }, // optional
            );
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
