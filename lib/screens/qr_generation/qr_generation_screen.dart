//import 'dart:io';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

import '../../provider/details_screen_event_provider.dart';
import '../../provider/qr_gen_provider.dart';
import '../widgets/my_text_field.dart';
import 'components/post_card_widget.dart';

class QrGenerationScreen extends StatelessWidget {
  final String eventId;
  const QrGenerationScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    context.read<QrGenProvider>().formaterDateMariage(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emettre une invitation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(
              key: context.watch<QrGenProvider>().globalKey,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.8,
                width: double.infinity,
                //color: Color.fromARGB(255, 20, 148, 65),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage(
                        'lib/assets/img/jay.png'), // Image de fond de la carte postale
                    fit: BoxFit.fill,
                  ),
                ),

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Ajouter les informations de la personne
                    Positioned(
                      bottom: 20,
                      right: 50,
                      child: QrImageView(
                        data: context.watch<QrGenProvider>().qrCodeData,
                        version: QrVersions.auto,
                        size: 75.0,
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                    ),

                    Positioned(
                      // top: 60,
                      top: 85,
                      left: 01,
                      child: SizedBox(
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width / 1.7,
                        height: 150,
                        child: Text(
                          'Chèr(e), ${context.watch<QrGenProvider>().inviterNameController.value.text}, ${context.watch<DetailsSreenEventProvider>().eventDetails['title']} sont Heureux de vous inviter à la célébration de leur mariage le ${context.watch<QrGenProvider>().dateMariage} à ${context.watch<DetailsSreenEventProvider>().eventDetails['salle']} ${context.watch<DetailsSreenEventProvider>().eventDetails['adresse']} ',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Parisienne',
                            color: Colors.white,
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      // top: 60,
                      bottom: 10,
                      left: 01,
                      child: SizedBox(
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width / 1.7,
                        height: 30,
                        child: Text(
                          ' ${context.watch<DetailsSreenEventProvider>().eventDetails['programme']} ',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'PlaywriteUSA',
                            color: Colors.white,
                            fontSize: 8,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 270,
                    //   child: SizedBox(
                    //     width: MediaQuery.of(context).size.width - 50,
                    //     child: Text(
                    //       '${context.watch<DetailsSreenEventProvider>().eventDetails['adresse']}',
                    //       textAlign: TextAlign.center,
                    //       style: const TextStyle(
                    //         color: Colors.yellow,
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     child: Image.asset(
                    //       'lib/assets/img/anneau.jpg',
                    //       width: 50.0, // Ajuste la taille du logo
                    //       height: 50.0, // Ajuste la taille du logo
                    //       fit: BoxFit
                    //           .cover, // Ajuste la couverture du logo dans le QR code
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    myTextFormField(
                      "Nom de l'invité",
                      Icons.person,
                      context.watch<QrGenProvider>().inviterNameController,
                      context,
                    ),
                    const SizedBox(height: 10),
                    myTextFormField(
                      "Table",
                      Icons.table_bar,
                      context.watch<QrGenProvider>().tableNameController,
                      context,
                    ),
                    const SizedBox(height: 10),
                    myTextFormField(
                      "Commentaire",
                      Icons.message,
                      context.watch<QrGenProvider>().commentNameController,
                      context,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      //     PostcardWidget(
      //   qrData: "https://example.com", // Les données pour ton QR code
      //   name: "John Doe",
      //   additionalInfo: "QR Code généré à partir de Flutter.",
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveQRCode(context),
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<void> _saveQRCode(BuildContext context) async {
    var status = await Permission.storage.request();
    try {
      status = await Permission.storage.status;

      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      // Demander la permission de stockage
      if (status.isGranted) {
        // Prendre un screenshot du QR code
        RenderRepaintBoundary boundary =
            Provider.of<QrGenProvider>(context, listen: false)
                .globalKey
                .currentContext!
                .findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        // Enregistrer le fichier dans la mémoire locale
        // final directory = await getDownloadsDirectory();
        // String filePath = '${directory!.path}/qrcode.png';
        // File imgFile = File(filePath);
        // await imgFile.writeAsBytes(pngBytes);

        // Obtenir le répertoire où sauvegarder l'image
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/qrcode.png';

        // Sauvegarder l'image en PNG
        File file = File(filePath);
        await file.writeAsBytes(pngBytes);

        // Sauvegarder dans la galerie
        await ImageGallerySaver.saveFile(filePath);

        context.read<QrGenProvider>().sendInviterInfoToServer(eventId);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('QR Code enregistré dans la galerie'),
          backgroundColor: Colors.green,
        ));

        context.read<QrGenProvider>().clearController();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Permission de stockage refusée'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print('Erreur lors de la sauvegarde: $e');
    }
  }
}
