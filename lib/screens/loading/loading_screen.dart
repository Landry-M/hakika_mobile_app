import 'package:flutter/material.dart';
import 'package:hakika/provider/presentation_provider.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../provider/authentication_provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    await _askStoragePermission();
    // Le Future.delayed est également déplacé ici pour s'exécuter après la demande de permission.
    // Si vous voulez qu'il s'exécute en parallèle, vous pouvez l'appeler sans await avant _askStoragePermission
    // ou le laisser tel quel pour qu'il s'exécute après.
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Vérifier si le widget est toujours monté avant d'accéder au context
        context.read<PresentationProvider>().generateRandomImages();
        context.read<AuthenticationProvider>().isAppUpToDate(context);
      }
    });
  }

  Future<void> _askStoragePermission() async {
    // Fall back to standard storage permission.
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      storageStatus =
          await Permission.storage.request(); // This should show a dialog
      if (storageStatus.isPermanentlyDenied) {
        // If storage permission is permanently denied, open app settings
        await openAppSettings();
      }
    }
    // Note: The overall permission status for the app would depend on whether
    // manageExternalStorage OR storage permission was granted.
    // The current 'status' variable holds the result of manageExternalStorage.
    // 'storageStatus' holds the result of storage permission.
    // App logic should check if *at least one* of the necessary permissions is granted.
  }
  // TODO: Add logic based on whether any required permission was ultimately granted.

  @override
  Widget build(BuildContext context) {
    // La logique de demande de permission et Future.delayed a été déplacée vers initState
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset('lib/assets/img/hakika2.png',
                width: 200, height: 200),
          ),
          const SizedBox(height: 5),
          const SizedBox(
            width: 200,
            child: LinearProgressIndicator(
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'version 1.0.4',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    ));
  }
} // End of _LoadingScreenState class
