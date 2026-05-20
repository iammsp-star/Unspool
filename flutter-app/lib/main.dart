import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/login_view.dart';
import 'views/dashboard_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Note: Firebase configuration requires running `flutterfire configure`.
  // We initialize gracefully here to avoid hard crashes in boilerplate phase.
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init failed or already initialized: $e");
  }
  
  runApp(
    const ProviderScope(
      child: UnspoolApp(),
    ),
  );
}

class UnspoolApp extends StatelessWidget {
  const UnspoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unspool',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthGate listens to Firebase Auth state changes to decide routing.
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

        // If the snapshot has user data, route them to the dashboard.
        if (snapshot.hasData) {
          return const DashboardView();
        }

        // Otherwise, they need to log in.
        return const LoginView();
      },
    );
  }
}
