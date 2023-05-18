import 'package:flutter/material.dart';
import 'package:graduaatsproef/screens/splashscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF1A1F24),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Image.asset(
                    'assets/images/checkpoint.png',
                    height: 120,
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Navigate to the settings page
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'About',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // Navigate to the about page
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            ListTile(
              title: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                onTapSignOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void onTapSignOut(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SplashScreen(),
      ),
    );
  }
}
