import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hakika/api/initialize_appwrite.dart';
import 'package:hakika/provider/chip_provider.dart';
import 'package:hakika/provider/details_screen_event_provider.dart';
import 'package:hakika/provider/event_details_provider.dart';
import 'package:hakika/provider/home_provider.dart';
import 'package:hakika/provider/home_provider_protocole.dart';
import 'package:hakika/provider/task_provider.dart';
import 'package:hakika/screens/details_event/details_event.dart';
import 'package:hakika/screens/details_event/details_event_hote.dart';
import 'package:hakika/screens/forgoted_password/Forgoted_password_screen.dart';
import 'package:hakika/screens/home/home_screen.dart';
import 'package:hakika/screens/home/home_screen_hote.dart';
import 'package:hakika/screens/home/home_screen_protocole.dart';
import 'package:hakika/screens/no_internet/no_internet_screen.dart';
import 'package:hakika/screens/profil/profil_screen.dart';
import 'package:provider/provider.dart';

import 'provider/authentication_provider.dart';
import 'provider/paiement_provider.dart';
import 'provider/presentation_provider.dart';
import 'provider/qr_gen_provider.dart';
import 'provider/user_preferences.dart';
import 'screens/loading/loading_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/login_register/login_register_screen.dart';
import 'screens/otp/otp_screen.dart';
import 'screens/presentation/presentation_screen.dart';
import 'screens/qr_generation/qr_generation_screen.dart';
import 'screens/register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  InitializeAppwrite().setDefaultParams();

  await UserPreferences.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 82, 20, 148),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color.fromARGB(255, 82, 20, 148),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChipProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QrGenProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PresentationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DetailsSreenEventProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProviderProtocole(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaiementProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Hakika',
      theme: ThemeData(
        // This is the theme of your application.
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 82, 20, 148),
        ),
        useMaterial3: true,
      ),
      //home: const DetailsEnventScreen(),
    );
  }

  final _router = GoRouter(
    initialLocation: '/loading',
    routes: [
      GoRoute(
        path: '/loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/presentation',
        builder: (context, state) => const PresentationScreen(),
      ),
      GoRoute(
        path: '/otp/:action',
        name: 'otp',
        builder: (context, state) =>
            OtpScreen(action: state.pathParameters['action']!),
      ),
      GoRoute(
          path: '/login-register',
          builder: (context, state) => const LoginRegisterScreen(),
          routes: [
            GoRoute(
              path: 'register',
              name: 'register',
              builder: (context, state) => const RegisterScreen(),
            ),
            GoRoute(
              path: 'login',
              name: 'login',
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: 'forgot-password',
              name: 'forgot-password',
              builder: (context, state) => const ForgotedPasswordScreen(),
            ),
          ]),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'profil',
            name: 'profil',
            builder: (context, state) => const ProfilScreen(),
          ),
          GoRoute(
            path: 'details-event/:eventId',
            name: 'details-event',
            builder: (context, state) {
              return DetailsEnventScreen(
                  eventId: state.pathParameters['eventId']!);
            },
            routes: [
              GoRoute(
                path: 'qr-gen-screen/:eventIdd',
                name: 'qr-gen-screen',
                builder: (context, state) => QrGenerationScreen(
                    eventId: state.pathParameters['eventIdd']!),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/home-protocole',
        name: 'home-protocole',
        builder: (context, state) => const HomeScreenProtocole(),
      ),
      GoRoute(
          path: '/home-hote',
          name: 'home-hote',
          builder: (context, state) => const HomeScreenHote(),
          routes: [
            GoRoute(
              path: 'details-event-hote/:eventId',
              name: 'details-event-hote',
              builder: (context, state) {
                return DetailsEnventHoteScreen(
                    eventId: state.pathParameters['eventId']!);
              },
            ),
          ]),
      GoRoute(
        path: '/no-internet',
        name: 'no-internet',
        builder: (context, state) => const NoInternetScreen(),
      ),
    ],
  );
}
