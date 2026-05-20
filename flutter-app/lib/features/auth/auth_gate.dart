import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../dashboard/dashboard_view.dart';
import 'login_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Check if the user is authenticated
        if (snapshot.hasData) {
          return const DashboardView();
        }

        // User is not authenticated, show login page
        return const LoginView();
      },
    );
  }
}
