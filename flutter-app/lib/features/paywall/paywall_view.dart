import 'package:flutter/material';
import '../../core/themes.dart';
import '../../core/constants.dart';

class PaywallView extends StatefulWidget {
  const PaywallView({super.key});

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  bool _isYearlySelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Need Help?', style: TextStyle(color: AppColors.textMuted)),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Upgrade to PLUS',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentGold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Reclaim your focus with absolute system blocks.',
                style: TextStyle(color: AppColors.textMuted, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Tier Comparison Matrix Table
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
                ),
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(width: 50, child: Text('Free', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.bold))),
                        SizedBox(width: 16),
                        SizedBox(width: 50, child: Text('PLUS', textAlign: TextAlign.center, style: TextStyle(color: AppColors.accentGold, fontWeight: FontWeight.bold))),
                      ],
                    ),
                    const Divider(color: AppColors.primaryDark, height: 24, thickness: 1),
                    _buildMatrixRow('Reel scroll count', true, true),
                    _buildMatrixRow('Daily scroll stats', true, true),
                    _buildMatrixRow('Reel Battle with friends', true, true),
                    _buildMatrixRow('Set limit on reels', false, true),
                    _buildMatrixRow('Set cool down time', false, true),
                    _buildMatrixRow('Reels Blocked from', false, true, isLast: true),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Visual Icon Row with Locks
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLockedPlatformIcon(Icons.play_circle_fill_rounded), // YouTube
                  _buildLockedPlatformIcon(Icons.camera_alt_rounded),       // Instagram
                  _buildLockedPlatformIcon(Icons.chat_bubble_rounded),      // Snapchat
                  _buildLockedPlatformIcon(Icons.facebook_rounded),         // Facebook
                  _buildLockedPlatformIcon(Icons.music_note_rounded),       // TikTok
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Subscription Selection Grid
              Row(
                children: [
                  Expanded(
                    child: _buildSubscriptionBox(
                      title: 'Yearly',
                      priceText: '₹25/month',
                      originalPrice: '₹999',
                      discountPrice: '₹299/year',
                      isSelected: _isYearlySelected,
                      badge: '70% OFF',
                      onTap: () => setState(() => _isYearlySelected = true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSubscriptionBox(
                      title: 'Monthly',
                      priceText: '₹99/month',
                      originalPrice: '',
                      discountPrice: 'Billed monthly',
                      isSelected: !_isYearlySelected,
                      onTap: () => setState(() => _isYearlySelected = false),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Primary CTA Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Text('CONTINUE', style: TextStyle(fontSize: 18, letterSpacing: 1.5)),
              ),
              
              const SizedBox(height: 16),
              const Text(
                'Billed Annually · Cancel Anytime',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatrixRow(String feature, bool freeHasIt, bool plusHasIt, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
      child: Row(
        children: [
          Expanded(child: Text(feature, style: const TextStyle(color: AppColors.textPrimary))),
          SizedBox(
            width: 50, 
            child: freeHasIt 
              ? const Icon(Icons.check_rounded, color: AppColors.statusSafe, size: 20)
              : const Icon(Icons.lock_rounded, color: AppColors.textMuted, size: 16)
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 50, 
            child: plusHasIt 
              ? const Icon(Icons.check_rounded, color: AppColors.accentGold, size: 20)
              : const Icon(Icons.lock_rounded, color: AppColors.textMuted, size: 16)
          ),
        ],
      ),
    );
  }

  Widget _buildLockedPlatformIcon(IconData icon) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryDark),
          ),
          child: Icon(icon, color: AppColors.textMuted, size: 24),
        ),
        Positioned(
          bottom: -4,
          right: -4,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.accentGold,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lock_rounded, color: AppColors.primaryDark, size: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildSubscriptionBox({
    required String title, 
    required String priceText, 
    required String originalPrice,
    required String discountPrice,
    required bool isSelected, 
    String? badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.accentGold.withOpacity(0.1) : AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
              border: Border.all(
                color: isSelected ? AppColors.accentGold : AppColors.surfaceDark,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: isSelected ? AppColors.accentGold : AppColors.textPrimary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(priceText, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                if (originalPrice.isNotEmpty) ...[
                  Text(originalPrice, style: const TextStyle(decoration: TextDecoration.lineThrough, color: AppColors.textMuted, fontSize: 12)),
                ],
                Text(discountPrice, style: const TextStyle(color: AppColors.statusSafe, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          if (badge != null)
            Positioned(
              top: -12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.statusDanger,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }
}
