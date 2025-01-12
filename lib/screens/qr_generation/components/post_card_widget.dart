import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

class PostcardWidget extends StatelessWidget {
  final String qrData;
  final String name;
  final String additionalInfo;

  PostcardWidget({
    required this.qrData,
    required this.name,
    required this.additionalInfo,
  });

  Future<void> _saveToGallery(GlobalKey key) async {
    final RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/postcard.png';
    final file = File(filePath);
    await file.writeAsBytes(buffer);

    // Enregistrer dans la galerie
    final result = await ImageGallerySaver.saveFile(filePath);
    print('Image saved to gallery: $result');
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();

    return RepaintBoundary(
      key: key,
      child: Container(
        width: 350,
        height: 400,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/assets/img/background_invitation.png'), // Image de fond de la carte postale
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            // Ajouter les informations de la personne
            Positioned(
              top: 60,
              left: 20,
              child: Text(
                'Nom: $name\n$additionalInfo',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Ajouter le QR Code
            Positioned(
              bottom: 20,
              right: 20,
              child: QrImageView(
                  data: qrData,
                  size: 100.0, //
                  foregroundColor: Colors.white),
            ),
            // Bouton pour sauvegarder l'image
          ],
        ),
      ),
    );
  }
}
