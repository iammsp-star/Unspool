import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../paywall/paywall_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unspool Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_rounded, color: Colors.amber),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PaywallView()),
              );
            },
            tooltip: 'Upgrade to Plus',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.deepPurple.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        '142',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Scrolls Today',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Recent Activity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const ListTile(
                leading: Icon(Icons.video_library),
                title: Text('YouTube Shorts'),
                trailing: Text('45 scrolls'),
              ),
              const ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Instagram Reels'),
                trailing: Text('97 scrolls'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
