import 'package:flutter/material';
import '../../core/themes.dart';
import '../../core/constants.dart';

class BattlesView extends StatelessWidget {
  const BattlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        title: const Text('Reel Battles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Active Matches Header
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Active Matches', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.history_rounded, size: 16, color: AppColors.textMuted),
                    label: const Text('History', style: TextStyle(color: AppColors.textMuted)),
                  )
                ],
              ),
            ),
            
            // Active Match Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                  border: Border.all(color: AppColors.accentGold.withOpacity(0.5)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      decoration: BoxDecoration(
                        color: AppColors.accentGold.withOpacity(0.1),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadiusMedium)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('⚔️ Weekend Detox Crew', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.accentGold)),
                          Text('Ends in 2d 14h', style: TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Live Leaderboard
                    _buildLeaderboardRow(rank: 1, name: 'Friend A', scrolls: 22, status: 'Safe 🟢', isCurrentUser: false),
                    _buildLeaderboardRow(rank: 2, name: 'Friend B', scrolls: 45, status: 'Safe 🟢', isCurrentUser: false),
                    _buildLeaderboardRow(rank: 3, name: 'Friend C', scrolls: 98, status: 'Warning 🟡', isCurrentUser: false),
                    _buildLeaderboardRow(rank: 4, name: 'You', scrolls: 142, status: 'Warning 🟡', isCurrentUser: true),
                    _buildLeaderboardRow(rank: 5, name: 'Friend D', scrolls: 250, status: 'Eliminated 🔴', isCurrentUser: false),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            
            const Spacer(),
            
            // Pending Invites / Other Rooms could go here
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.accentGold,
        foregroundColor: AppColors.primaryDark,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Create/Join Battle Room', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildLeaderboardRow({
    required int rank, 
    required String name, 
    required int scrolls, 
    required String status,
    required bool isCurrentUser,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium, vertical: 12),
      color: isCurrentUser ? AppColors.surfaceDark.withOpacity(0.8) : Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '#$rank', 
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: rank == 1 ? AppColors.accentGold : AppColors.textMuted
              )
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name, 
              style: TextStyle(
                fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
                color: AppColors.textPrimary,
              )
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$scrolls Scrolls', style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
              Text(status, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
            ],
          )
        ],
      ),
    );
  }
}
