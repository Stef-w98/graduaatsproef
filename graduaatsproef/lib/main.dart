import 'package:flutter/material.dart';
import 'package:graduaatsproef/screens/account_management_screen.dart';
import 'package:graduaatsproef/screens/analytics_screen.dart';
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
  static const String analyticsScreen = "/analyticsScreen";
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckPoint',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.yellow,
        fontFamily: 'Montserrat',
        // define other properties here
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[800],
        accentColor: Colors.amberAccent,
        fontFamily: 'Montserrat',
        // define other properties here
      ),
      home: AnalyticsScreen(),
      initialRoute: '/splashscreen',
      routes: {
        ScreenPath.signin: (context) => const SignInScreen(),
        ScreenPath.signup: (context) => const SignUpScreen(),
        ScreenPath.homeScreen: (context) => const HomeScreen(),
        ScreenPath.checkInOutScreen: (context) => const CheckInOutScreen(),
        ScreenPath.accountManagementScreen: (context) =>
            const AccountManagementScreen(),
        ScreenPath.analyticsScreen: (context) => AnalyticsScreen(),
        ScreenPath.splashscreen: (context) => const SplashScreen(),
        //ScreenPath.notification: (context) => const MedicationNotificationsPage()
      },
    );
  }
}
