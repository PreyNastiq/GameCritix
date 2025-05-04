import 'package:flutter/material.dart';
import 'package:game_critix/Pages/HomePage.dart';
import 'package:game_critix/Pages/LoginPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // Listen to auth state changes
        stream: Supabase.instance.client.auth.onAuthStateChange,

        //Auth state changes
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }

          // Check if the user is authenticated
          final session = snapshot.hasData ? snapshot.data!.session : null;

          if (session != null) {
            return HomePage();
          } else {
            return LoginPage();
          }
        });
  }
}
