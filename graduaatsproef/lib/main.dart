import 'package:flutter/material.dart';
import 'package:graduaatsproef/screens/account_management_screen.dart';
import 'package:graduaatsproef/screens/in_office_screen.dart';
import 'package:graduaatsproef/screens/checkinout_screen.dart';
import 'package:graduaatsproef/screens/home_screen.dart';
import 'package:graduaatsproef/screens/sign_in_screen.dart';
import 'package:graduaatsproef/screens/sign_up_screen.dart';
import 'package:graduaatsproef/screens/splashscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenPath {
  static const String homeScreen = "/homeScreen";
  static const String checkInOutScreen = "/checkInOutScreen";
  static const String accountManagementScreen = "/accountManagementScreen";
  static const String InOfficeScreen = "/InOfficeScreen";
  static const String signin = "/signin";
  static const String signup = "/signup";
  static const String splashscreen = "/splashscreen";
  //static const String notification = "/MedicationNotificationsPage";
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://vxroeuhrwukfubpxezrp.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4cm9ldWhyd3VrZnVicHhlenJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzg5OTc3NzAsImV4cCI6MTk5NDU3Mzc3MH0.KvUbmkAsNCOOmz4ag5fA5Wq1WCnmaznkOaPg5caCfAE',
      authCallbackUrlHostname: 'login-callback',
      debug: false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final MaterialColor primarySwatch = const MaterialColor(
    0xFF4B39EF, // primary color
    <int, Color>{
      50: Color(0xFFE8E6FC),
      100: Color(0xFFC5C1F6),
      200: Color(0xFF9F9AEF),
      300: Color(0xFF7973E8),
      400: Color(0xFF5C53E3),
      500: Color(0xFF4B39EF), // same as primary color
      600: Color(0xFF422FE8),
      700: Color(0xFF3826E1),
      800: Color(0xFF301ED9),
      900: Color(0xFF1F0ECB),
    },
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckPoint',
      theme: ThemeData(
        bottomAppBarTheme:
            const BottomAppBarTheme(surfaceTintColor: Color(0xFF4B39EF)),
        primarySwatch: primarySwatch,
      ),
      home: InOfficeScreen(),
      initialRoute: '/splashscreen',
      routes: {
        ScreenPath.signin: (context) => const SignInScreen(),
        ScreenPath.signup: (context) => const SignUpScreen(),
        ScreenPath.homeScreen: (context) => const HomeScreen(),
        ScreenPath.checkInOutScreen: (context) => const CheckInOutScreen(),
        ScreenPath.accountManagementScreen: (context) =>
            AccountManagementScreen(),
        ScreenPath.InOfficeScreen: (context) => InOfficeScreen(),
        ScreenPath.splashscreen: (context) => const SplashScreen(),
        //ScreenPath.notification: (context) => const MedicationNotificationsPage()
      },
    );
  }
}
