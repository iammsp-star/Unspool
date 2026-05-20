import 'package:flutter/material';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'core/themes.dart';
import 'features/auth/auth_gate.dart';
import 'features/dashboard/dashboard_view.dart';
import 'features/paywall/paywall_view.dart';
import 'features/battles/battles_view.dart';
import 'features/lockout/lockout_overlay_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Note: Firebase configuration requires actual google-services.json to compile.
  // await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        // Replace with actual Provider classes in production
        Provider<String>.value(value: 'Unspool State'), 
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
      theme: AppTheme.sleekCyberDark, // Hooking up the new Cyber-Dark Theme
      debugShowCheckedModeBanner: false,
      
      // We start at the AuthGate to determine user state
      // (Bypassing Firebase initialization constraint for preview)
      initialRoute: '/',
      
      routes: {
        // '/': (context) => const AuthGate(),
        '/': (context) => const _DevNavigationScreen(), // Temporary Dev Screen
        '/dashboard': (context) => const DashboardView(),
        '/paywall': (context) => const PaywallView(),
        '/battles': (context) => const BattlesView(),
        '/lockout': (context) => const LockoutOverlayView(),
      },
    );
  }
}

/// A temporary development screen to let the user preview all the new views
/// easily without needing to configure Firebase authentication first.
class _DevNavigationScreen extends StatelessWidget {
  const _DevNavigationScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(title: const Text('Unspool - Developer Preview')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/dashboard'),
              child: const Text('View Core Dashboard'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/battles'),
              child: const Text('View Reel Battles'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/paywall'),
              child: const Text('View Premium Paywall'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.statusDanger),
              onPressed: () => Navigator.pushNamed(context, '/lockout'),
              child: const Text('Trigger System Lockout Overlay'),
            ),
          ],
        ),
      ),
    );
  }
}
