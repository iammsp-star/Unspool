import 'package:flutter/material.dart';

class PaywallView extends StatelessWidget {
  const PaywallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade to Plus'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.workspace_premium_rounded,
                size: 80,
                color: Colors.amber,
              ),
              const SizedBox(height: 24),
              Text(
                'Unlock Hard Limits',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              _buildFeatureRow(Icons.check_circle, 'System-level app blocking'),
              const SizedBox(height: 16),
              _buildFeatureRow(Icons.check_circle, 'Custom cooldown timers'),
              const SizedBox(height: 16),
              _buildFeatureRow(Icons.check_circle, 'Cross-platform sync locks'),
              const Spacer(),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Subscribe for ₹99/month',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber),
        const SizedBox(width: 16),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
