import 'package:appwrite/appwrite.dart';

class InitializeAppwrite {
  setDefaultParams() {
    Client client = Client();
    client
        .setEndpoint('http://31.220.73.179/v1')
        .setProject('675137c200067680c109')
        .setSelfSigned(
          status: true,
        ); // For self signed certificates, only use for development
    return client;
  }
}
