import 'package:flutter/material';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/themes.dart';
import '../../core/constants.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  void _signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // Desktop Layout
          return _buildDesktopLayout(context);
        } else {
          // Mobile Layout
          return _buildMobileLayout(context);
        }
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left-hand sticky sidebar navigation
          Container(
            width: 250,
            color: AppColors.surfaceDark,
            child: Column(
              children: [
                const SizedBox(height: 48),
                const Text('Unspool', style: TextStyle(color: AppColors.accentGold, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 48),
                _SidebarItem(icon: Icons.dashboard_rounded, label: 'Dashboard', isActive: true),
                _SidebarItem(icon: Icons.shield_moon_rounded, label: 'Battles'),
                _SidebarItem(icon: Icons.rule_rounded, label: 'System Rules'),
                const Spacer(),
                ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.textMuted),
                  title: const Text('Sign Out', style: TextStyle(color: AppColors.textMuted)),
                  onTap: _signOut,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          
          // Main Content Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingXLarge),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Hero Metrics (Massive analytics chart)
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('System Focus Overview', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                            border: Border.all(color: AppColors.surfaceDark.withOpacity(0.5)),
                          ),
                          child: const Center(
                            child: Text(
                              '[Hero Analytics Chart Placeholder]\nTracking window focus changes & distraction times.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.textMuted),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: AppConstants.paddingXLarge),
                  
                  // Right Column: The Grid (Desktop site blocker modules)
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Active Monitors', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        _DesktopMonitorCard(domain: 'instagram.com/reels', count: 42, limit: 50),
                        const SizedBox(height: 16),
                        _DesktopMonitorCard(domain: 'youtube.com/shorts', count: 18, limit: 30),
                        const SizedBox(height: 16),
                        _DesktopMonitorCard(domain: 'tiktok.com', count: 82, limit: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome back, ${FirebaseAuth.instance.currentUser?.displayName?.split(' ').first ?? 'User'}',
                style: const TextStyle(color: AppColors.textMuted, fontSize: 16),
              ),
              const SizedBox(height: 32),
              
              // Central Concentric Ring
              Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surfaceDark, width: 8),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Simulated progress ring
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: 142 / 200,
                          strokeWidth: 8,
                          backgroundColor: Colors.transparent,
                          color: AppColors.accentGold,
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '142 / 200',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'monospace',
                            ),
                          ),
                          Text('scrolls today', style: TextStyle(color: AppColors.textMuted)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 48),
              
              // 2x2 Platform Breakdown Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _PlatformGridBlock(title: 'Instagram', metrics: '80 scrolls', icon: Icons.camera_alt_rounded, progress: 0.8),
                  _PlatformGridBlock(title: 'YouTube', metrics: '24 mins', icon: Icons.play_arrow_rounded, progress: 0.4),
                  _PlatformGridBlock(title: 'Snapchat', metrics: '12 scrolls', icon: Icons.chat_bubble_rounded, progress: 0.2),
                  _PlatformGridBlock(title: 'TikTok', metrics: '26 scrolls', icon: Icons.music_note_rounded, progress: 0.6),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.shield_moon_rounded), label: 'Reel Battle'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}

// Helper Widgets

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _SidebarItem({required this.icon, required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isActive ? AppColors.accentGold.withOpacity(0.1) : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: isActive ? AppColors.accentGold : AppColors.textMuted),
        title: Text(
          label, 
          style: TextStyle(
            color: isActive ? AppColors.accentGold : AppColors.textMuted,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          )
        ),
        onTap: () {},
      ),
    );
  }
}

class _DesktopMonitorCard extends StatelessWidget {
  final String domain;
  final int count;
  final int limit;

  const _DesktopMonitorCard({required this.domain, required this.count, required this.limit});

  @override
  Widget build(BuildContext context) {
    final double progress = count / limit;
    final bool isWarning = progress > 0.8;
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.web_rounded, size: 16, color: AppColors.textMuted),
              const SizedBox(width: 8),
              Text(domain, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$count / $limit', style: const TextStyle(fontFamily: 'monospace', fontSize: 16)),
              Text('scrolls', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.primaryDark,
            color: isWarning ? AppColors.statusDanger : AppColors.statusSafe,
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

class _PlatformGridBlock extends StatelessWidget {
  final String title;
  final String metrics;
  final IconData icon;
  final double progress;

  const _PlatformGridBlock({
    required this.title,
    required this.metrics,
    required this.icon,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final bool isWarning = progress > 0.75;
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.textPrimary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title, 
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metrics,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.primaryDark,
                color: isWarning ? AppColors.statusDanger : AppColors.statusSafe,
                minHeight: 4,
                borderRadius: BorderRadius.circular(2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
