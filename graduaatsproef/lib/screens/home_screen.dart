import 'package:flutter/material.dart';
import 'package:graduaatsproef/screens/sign_in_screen.dart';
import 'package:graduaatsproef/widgets/drawer_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F24),
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF090F13),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to My App!',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () {
                onTapSignOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void onTapSignOut() async {
  await Supabase.instance.client.auth.signOut();
}
