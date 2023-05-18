import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduaatsproef/screens/bottom_navigation_bar.dart';
import 'package:graduaatsproef/screens/sign_in_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Start the timer for 2 seconds and redirect to the appropriate screen
    Timer(const Duration(seconds: 2), () {
      _redirectToAppropriateScreen(context);
    });

    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 29, 29, 29),
      child: Center(
        child: Image.asset(
          'assets/images/checkpoint.png',
        ),
      ),
    ));
  }

  void _redirectToAppropriateScreen(BuildContext context) async {
    bool isLoggedIn = await SupabaseAuth.instance.hasAccessToken;
    // if (isLoggedIn) {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const TodayPage()),
    //   );
    // } else {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const SignInScreen()),
    //   );
    // }
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const BottomNavigation(NavigationPage.checkInOutScreen)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const SignInScreen()), // TODO: change sign in screen bottom bar
      );
    }
  }
}
