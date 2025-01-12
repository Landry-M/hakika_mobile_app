import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hakika/provider/user_preferences.dart';

import '../models/user_model.dart';

class PresentationProvider with ChangeNotifier {
  final List<String> _onBoardingImages = [
    'lib/assets/img/1.jpeg',
    'lib/assets/img/2.jpeg',
    'lib/assets/img/3.jpeg',
    'lib/assets/img/4.jpeg',
    'lib/assets/img/5.jpeg',
    'lib/assets/img/6.jpeg',
    'lib/assets/img/7.jpeg',
    'lib/assets/img/8.jpeg',
    'lib/assets/img/9.jpeg',
    'lib/assets/img/dany1.jpg',
    'lib/assets/img/dany2.jpg',
    'lib/assets/img/lan.jpg',
  ];
  late List<String> _randomImages;

  List<String> get randomImages => _randomImages;

  PageController controller = PageController();

  void generateRandomImages() {
    final random = Random();
    _randomImages = List<String>.from(_onBoardingImages);
    _randomImages.shuffle(random);
    _randomImages = _randomImages.take(3).toList(); // Par défaut, 3 images
    notifyListeners();
  }

  setFirstLaunchAppAtFalse(BuildContext context) async {
    UserModel userInfo = UserPreferences.getUserInfo();
    if (userInfo.isLogin == true && userInfo.otpEntered == true) {
      context.go('/home');
    } else {
      var result = userInfo.copy(firstLaunchApp: true);

      await UserPreferences.setUserInfo(result);

      notifyListeners();

      context.go('/login-register');
    }
  }
}
