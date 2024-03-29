import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  void onAuthenticated(Session session) async {
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/homeScreen');
    }
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {}
}
