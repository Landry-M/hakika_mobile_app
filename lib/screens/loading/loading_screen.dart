import 'package:flutter/material.dart';
import 'package:hakika/provider/presentation_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/authentication_provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      context.read<PresentationProvider>().generateRandomImages();
      context.read<AuthenticationProvider>().verifyFirstLaunchApp(context);
    });

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
            'version 1.3.0',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    ));
  }
}
