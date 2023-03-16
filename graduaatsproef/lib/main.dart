import 'package:flutter/material.dart';
import 'package:graduaatsproef/screens/account_management_screen.dart';
import 'package:graduaatsproef/screens/analytics_screen.dart';
import 'package:graduaatsproef/screens/checkinout_screen.dart';
import 'package:graduaatsproef/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScreenPath {
  static const String homeScreen = "/homeScreen";
  static const String checkInOutScreen = "/checkInOutScreen";
  static const String accountManagementScreen = "/accountManagementScreen";
  static const String analyticsScreen = "/analyticsScreen";
  //static const String signin = "/signin";
  //static const String signup = "/sigup";
  //static const String splashscreen = "/splashscreen";
  //static const String notification = "/MedicationNotificationsPage";
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://zyyttgrfyefxxlgesoke.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp5eXR0Z3JmeWVmeHhsZ2Vzb2tlIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njg2OTY5NDksImV4cCI6MTk4NDI3Mjk0OX0.Dl7Gfm9KQvATcZyx7KkMffWLbfQC0DrM1KCLglJDM0U',
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
        bottomAppBarTheme:
            const BottomAppBarTheme(surfaceTintColor: Colors.blueAccent),
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      initialRoute: '/homeScreen',
      routes: {
        //ScreenPath.signin: (context) => const SignInScreen(),
        //ScreenPath.signup: (context) => const SignUpScreen(),
        ScreenPath.homeScreen: (context) => const HomeScreen(),
        ScreenPath.checkInOutScreen: (context) => const CheckInOutScreen(),
        ScreenPath.accountManagementScreen: (context) =>
            const AccountManagementScreen(),
        ScreenPath.analyticsScreen: (context) => AnalyticsScreen(),
        //ScreenPath.splashscreen: (context) => const SplashScreen(),
        //ScreenPath.notification: (context) => const MedicationNotificationsPage()
      },
    );
  }
}
