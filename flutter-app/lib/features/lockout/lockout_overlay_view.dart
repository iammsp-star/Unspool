import 'package:flutter/material';
import '../../core/themes.dart';

class LockoutOverlayView extends StatelessWidget {
  // In a real implementation, this would likely take a Stream/ValueNotifier for the timer
  final String remainingTime; 

  const LockoutOverlayView({
    super.key, 
    this.remainingTime = '14:59',
  });

  @override
  Widget build(BuildContext context) {
    // WillPopScope equivalent to prevent Android back button bypassing
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.primaryDark,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon to signify locked state
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.statusDanger.withOpacity(0.5), width: 2),
                    ),
                    child: const Icon(
                      Icons.lock_clock_rounded,
                      size: 64,
                      color: AppColors.statusDanger,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Countdown Timer
                  Text(
                    remainingTime,
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'monospace',
                      color: AppColors.textPrimary,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'remaining isolation time',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textMuted,
                      letterSpacing: 2,
                    ),
                  ),
                  
                  const SizedBox(height: 64),
                  
                  // Psychological Breaker Copy
                  const Text(
                    'Step away.\nTake a deep breath.\nFocus on reality.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.textMuted,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  
                  // Notice: No bypass buttons are present on this screen by design.
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
