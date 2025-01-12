import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hakika/models/user_model.dart';
import 'package:hakika/provider/mail_provider.dart';
import 'package:hakika/screens/forgoted_password/components/bottom_sheet_for_reset_password.dart';
import 'package:otp_text_field/otp_text_field.dart';

import '../api/initialize_appwrite.dart';
import 'user_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  final Pagecontroller = PageController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  bool obscurText = true;
  bool loginEnCours = false;
  bool isOtpCorrect = false;
  bool isUpdatingUserInfo = false;
  final formKey = GlobalKey<FormState>();
  String selectedRole = 'organisateur';
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  var otpCode;
  OtpFieldController otpController = OtpFieldController();
  String userName = '';
  String eventId = '';
  String userRole = '';
  String userEmail = '';
  String userPhone = '';
  String userId = '';

  final List<String> rolesList = ['organisateur', 'protocole', 'hote'];

  setUserInfoInVariable() {
    UserModel userInfo = UserPreferences.getUserInfo();
    userName = userInfo.name;
  }

  setPasswordObscured() {
    obscurText = !obscurText;
    notifyListeners();
  }

  setSelectedRole(role) {
    selectedRole = role;
    notifyListeners();
  }

  verifyFirstLaunchApp(BuildContext context) async {
    UserModel userInfo = UserPreferences.getUserInfo();

    //if user if logged in and otp entered
    if (userInfo.isLogin == true) {
      if (userInfo.otpEntered == true) {
        switch (userInfo.role) {
          case 'protocole':
            context.go('/home-protocole');
            break;
          case 'organisateur':
            context.go('/home');
            break;
          case 'hote':
            context.go('/home-hote');
            break;
          default:
            context.goNamed('otp', pathParameters: {'action': 'login'});
            break;
        }
      } else {
        context.goNamed('otp', pathParameters: {'action': 'login'});
      }
    } else {
      //
      // userInfo.copy(role: 'user');
      // await UserPreferences.setUserInfo(userInfo);

      userInfo.firstLaunchApp
          ? context.go('/presentation')
          : context.go('/login-register');
    }
  }

  setOtp(String value) {
    otpCode = otpCode.toString() + value.toString();
    //print(otpCode);
  }

  verifyOtp(BuildContext context, String optValue, String action) async {
    loginEnCours = true;
    var result = EmailOTP.verifyOTP(otp: optValue.trim());
    print(result);
    if (action == 'register') {
      if (result == true) {
        UserModel userInfo = UserPreferences.getUserInfo();
        var userPrefs = userInfo.copy(
          role: 'organisateur',
          isLogin: true,
          otpEntered: true,
        );

        await UserPreferences.setUserInfo(userPrefs);
        UserModel newUserInfo = UserPreferences.getUserInfo();
        //enregistrement des donnees dans appwrite

        final client = InitializeAppwrite().setDefaultParams();
        final databases = Databases(client);

        try {
          await databases.createDocument(
              databaseId: '67515e94000ade29c6a3',
              collectionId: '67529c8600169afe18f3',
              documentId: ID.unique(),
              data: {
                "name": newUserInfo.name,
                "email": newUserInfo.email,
                "phone": newUserInfo.phone,
                "role": newUserInfo.role,
                "user_id": newUserInfo.userId,
              });
          context.goNamed('home');
        } on AppwriteException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message ?? ""),
            ),
          );
        }
      } else {
        loginEnCours = false;
        otpController.clear();
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mot de passe a usage unique incorrect'),
          ),
        );
      }
      otpController.clear();
      loginEnCours = false;
      notifyListeners();
    } else if (action == 'login') {
      if (result == true) {
        UserModel userInfo = UserPreferences.getUserInfo();
        var userPrefs = userInfo.copy(
          role: 'organisateur',
          isLogin: true,
          otpEntered: true,
        );

        await UserPreferences.setUserInfo(userPrefs);

        context.goNamed('home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mot de passe a usage unique incorrect'),
          ),
        );
      }
      loginEnCours = false;
      notifyListeners();
    } else if (action == 'reset-password') {
      if (result == true) {
        isOtpCorrect = true;
        loginEnCours = false;

        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mot de passe a usage unique incorrect'),
          ),
        );
      }
    }
  }

  void changeStateOfOtp(newValue) {
    isOtpCorrect = newValue;
    notifyListeners();
  }

//login connexion a un compte
  loginUser(BuildContext context) async {
    loginEnCours = true;
    notifyListeners();

    if (selectedRole == 'organisateur') {
      final account = Account(InitializeAppwrite().setDefaultParams());

      //const session = await account.createEmailPasswordSession(email, password);
      try {
        final session = await account.createEmailPasswordSession(
          email: emailController.value.text,
          password: passwordController.value.text,
        );

        // print(session.userId);

        //recuperation des info de l'utilisateur dans la collection users
        final databases = Databases(InitializeAppwrite().setDefaultParams());

        var result = await databases.listDocuments(
          databaseId: '67515e94000ade29c6a3',
          collectionId: '67529c8600169afe18f3',
          //  documentId: session.userId,
          queries: [
            Query.equal('user_id', session.userId),
          ],
        );

        var myUser = result.documents.map((doc) => doc.data).toList();
        //print(myUser[0]['name']);
        // UserModel userInfo = UserPreferences.getUserInfo();

        UserModel userInfo = UserPreferences.getUserInfo();

        var userPrefs = userInfo.copy(
          userId: session.userId,
          name: myUser[0]['name'],
          email: emailController.value.text,
          phone: myUser[0]['phone'],
          role: 'organisateur',
          isLogin: true,
          otpEntered: false,
        );

        await UserPreferences.setUserInfo(userPrefs);

        userRole = 'organisateur';

        await MailProvider().sendOtpEmail(emailController.value.text);

        clearAllController();

        notifyListeners();

        context.goNamed(
          'otp',
          pathParameters: {'action': 'login'},
        );
        // var userPrefs = userInfo.copy(
        //   userId: session.userId,
        //   name: session.clientCode,
        //   email: emailController.value.text,
        //   role: 'organisateur',
        //   isLogin: true,
        //   otpEntered: false,
        // );

        // await UserPreferences.setUserInfo(userPrefs);
      } on AppwriteException catch (e) {
        // Gérer les erreurs Appwrite
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? ''),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Une erreur s'est produite lors de la connexion")));
      }

      loginEnCours = false;

      passwordController.clear();

      notifyListeners();
    } else if (selectedRole == 'protocole') {
      //verifier si le nom et le pin du protocole existe dans appwrite

      final databases = Databases(InitializeAppwrite().setDefaultParams());

      try {
        final response = await databases.listDocuments(
          databaseId: '67515e94000ade29c6a3',
          collectionId: '6753d82500233a49ef4d', // collection protocole

          queries: [
            Query.equal('nom', nameController.value.text),
            Query.equal(
              'pin',
              int.parse(passwordController.value.text),
            ),
          ],
        );

        if (response.documents.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("Veuillez revérifier vos informations de connexion"),
            ),
          );
        } else {
          UserModel userInfo = UserPreferences.getUserInfo();
          var userPrefs = userInfo.copy(
            userId: response.documents[0].data['\$id'],
            name: response.documents[0].data['nom'],
            role: 'protocole',
            eventId: response.documents[0].data['event_id'],
            isLogin: true,
            otpEntered: true,
          );

          await UserPreferences.setUserInfo(userPrefs);
          userName = response.documents[0].data['nom'];
          eventId = response.documents[0].data['event_id'];
          userRole = 'protocole';
          // UserModel newUserInfo = UserPreferences.getUserInfo();

          loginEnCours = false;

          clearAllController();

          notifyListeners();

          context.goNamed('home-protocole');
        }
      } on AppwriteException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur $e"),
          ),
        );
      } catch (e) {
        SnackBar(
          content: Text("Erreur $e"),
        );
      }
    } else if (selectedRole == 'hote') {
      //verifier si le nom et le pin du protocole existe dans appwrite

      final databases = Databases(InitializeAppwrite().setDefaultParams());

      try {
        final response = await databases.listDocuments(
          databaseId: '67515e94000ade29c6a3',
          collectionId: '67638e040014df5c2ed7', // collection hotes

          queries: [
            Query.equal('nom', nameController.value.text),
            Query.equal(
              'pin',
              int.parse(passwordController.value.text),
            ),
          ],
        );

        if (response.documents.isEmpty) {
          loginEnCours = false;
          notifyListeners();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("Veuillez revérifier vos informations de connexion"),
            ),
          );
        } else {
          // print(response.documents[0].data['event_id']);
          UserModel userInfo = UserPreferences.getUserInfo();
          var userPrefs = userInfo.copy(
            userId: response.documents[0].data['\$id'],
            name: response.documents[0].data['nom'],
            role: 'hote',
            eventId: response.documents[0].data['event_id'],
            isLogin: true,
            otpEntered: true,
          );

          await UserPreferences.setUserInfo(userPrefs);
          userName = response.documents[0].data['nom'];
          eventId = response.documents[0].data['event_id'];
          userRole = 'hote';
          // UserModel newUserInfo = UserPreferences.getUserInfo();

          loginEnCours = false;

          clearAllController();

          notifyListeners();

          context.goNamed('home-hote');
        }
      } on AppwriteException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur $e"),
          ),
        );
      } catch (e) {
        SnackBar(
          content: Text("Erreur $e"),
        );
      }
    }
  }

  resendOtp() async {
    loginEnCours = true;
    notifyListeners();

    UserModel userInfo = UserPreferences.getUserInfo();
    await MailProvider().sendOtpEmail(userInfo.email);
    loginEnCours = false;
    notifyListeners();
  }

//creation de ocmpte organisateur
  registerUser(BuildContext context) async {
    loginEnCours = true;
    notifyListeners();

    final account = Account(InitializeAppwrite().setDefaultParams());
    var userUniqueId = ID.unique();

    try {
      await account.create(
        userId: userUniqueId,
        name: nameController.value.text,
        email: emailController.value.text,
        password: passwordController.value.text,
      );

      UserModel userInfo = UserPreferences.getUserInfo();

      var userPrefs = userInfo.copy(
        userId: userUniqueId,
        name: nameController.value.text,
        email: emailController.value.text,
        phone: phoneController.value.text,
        role: 'organisateur',
        isLogin: true,
        otpEntered: false,
        firstLaunchApp: false,
      );

      await UserPreferences.setUserInfo(userPrefs);

      await MailProvider().sendOtpEmail(emailController.value.text);

      clearAllController();

      notifyListeners();

      context.goNamed('otp', pathParameters: {'action': 'register'});
    } on AppwriteException catch (e) {
      // Gérer les erreurs Appwrite
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? ''),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Une erreur s'est produite lors de la connexion")));
    }

    loginEnCours = false;

    notifyListeners();
  }

  void logoutUser(BuildContext context) async {
    if (userRole == 'organisateur') {
      UserModel userInfo = UserPreferences.getUserInfo();

      var userPrefs = userInfo.copy(
        isLogin: false,
        otpEntered: false,
        firstLaunchApp: true,
        role: 'user',
        userId: '0',
        eventId: '0',
      );

      await UserPreferences.setUserInfo(userPrefs);

      clearAllController();

      final account = Account(InitializeAppwrite().setDefaultParams());

      await account.deleteSessions();

      notifyListeners();

      exit(0);
    } else {
      logoutProtocole(context);
    }
  }

  logoutProtocole(BuildContext context) async {
    UserModel userInfo = UserPreferences.getUserInfo();

    var userPrefs = userInfo.copy(
      isLogin: false,
      otpEntered: false,
      firstLaunchApp: true,
      role: 'user',
      userId: '0',
      eventId: '0',
    );

    await UserPreferences.setUserInfo(userPrefs);

    clearAllController();

    notifyListeners();

    exit(0);
  }

  void clearAllController() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void checkUserEmailAndPassword(BuildContext context) async {
    loginEnCours = true;
    notifyListeners();

    try {
      final databases = Databases(InitializeAppwrite().setDefaultParams());

      var result = await databases.listDocuments(
        databaseId: '67515e94000ade29c6a3',
        collectionId: '67529c8600169afe18f3', //collection users
        //  documentId: session.userId,
        queries: [
          Query.equal('email', emailController.value.text),
          Query.equal('phone', phoneController.value.text),
        ],
      );

      if (result.documents.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "Email et mot de passe inéxistant. Nous ne pouvons rien faire."),
          ),
        );
      } else {
        await MailProvider().sendOtpEmail(emailController.value.text);

        bottomSheetForResetPassword(context);
      }

      loginEnCours = false;
      notifyListeners();
    } catch (e) {}
  }

  void updateUserInfo(BuildContext context) async {
    isUpdatingUserInfo = true;
    notifyListeners();

    final databases = Databases(InitializeAppwrite().setDefaultParams());

    final account = Account(InitializeAppwrite().setDefaultParams());

    final userInfoInOnlineDb = await databases.listDocuments(
      databaseId: '67515e94000ade29c6a3',
      collectionId: '67529c8600169afe18f3', //collection users
      queries: [Query.equal('user_id', userId)], // optional
    );

    print(userInfoInOnlineDb.documents[0].data['\$id']);

    await databases.updateDocument(
      databaseId: '67515e94000ade29c6a3',
      collectionId: '67529c8600169afe18f3', //collection users
      documentId: userInfoInOnlineDb.documents[0].data['\$id'],
      data: {
        'name': nameController.value.text,
        'email': emailController.value.text,
        'phone': phoneController.value.text,
      },
    );

    final response = await account.updateName(name: nameController.value.text);
    final responseEmail = await account.updateEmail(
        email: emailController.value.text,
        password: passwordController.value.text);

    print(responseEmail);
    UserModel userInfo = UserPreferences.getUserInfo();

    var userPrefs = userInfo.copy(
      name: nameController.value.text,
      email: emailController.value.text,
      phone: phoneController.value.text,
    );

    await UserPreferences.setUserInfo(userPrefs);

    isUpdatingUserInfo = false;
    notifyListeners();
  }

  void loadUserInfoInLocalVariable() async {
    UserModel userInfo = UserPreferences.getUserInfo();
    userName = userInfo.name;
    eventId = userInfo.eventId;
    userRole = userInfo.role;
    userEmail = userInfo.email;
    userPhone = userInfo.phone;
    userId = userInfo.userId;
    print(userRole);
  }
}
