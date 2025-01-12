import 'package:appwrite/appwrite.dart';

import 'initialize_appwrite.dart';

class AuthenticationRequest {
  loginUser(String email, String password) async {
    final account = Account(InitializeAppwrite().setDefaultParams());

    //const session = await account.createEmailPasswordSession(email, password);
    try {
      final session = await account.createEmailPasswordSession(
          email: email, password: password);
      //print(session);
      return session;
    } catch (e) {
      // print(e);
      return e;
    }
  }
}
