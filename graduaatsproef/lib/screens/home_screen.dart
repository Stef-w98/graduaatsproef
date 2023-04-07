import 'package:flutter/material.dart';
import 'package:graduaatsproef/services/database/database_service.dart';
import 'package:graduaatsproef/widgets/drawer_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uuid = Uuid();
    final randomUid = uuid.v4();
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
              child: const Text('Add NFC card'),
              onPressed: () {
                DatabaseService()
                    .nfcCardsService
                    .addCard(userId: 1, cardUid: randomUid);
              },
            ),
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
