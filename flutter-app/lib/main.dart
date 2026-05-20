import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'core/themes.dart';
import 'features/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Platform-agnostic Firebase initialization
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init failed or already initialized: $e");
  }
  
  runApp(
    MultiProvider(
      providers: [
        // Setup global providers here
        Provider<String>(create: (_) => 'Example Provider State'),
      ],
      child: const UnspoolApp(),
    ),
  );
}

class UnspoolApp extends StatelessWidget {
  const UnspoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unspool',
      theme: AppThemes.darkTheme,
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
