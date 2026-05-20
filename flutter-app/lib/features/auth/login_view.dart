import 'package:flutter/material';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/themes.dart';
import '../../core/constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }
      
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Navigation is handled by AuthGate in main.dart
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The design requires a deep black background
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
        child: Stack(
          children: [
            // Glowing vertical thread animation
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.6),
                    painter: _ThreadPainter(progress: _animationController.value),
                  );
                },
              ),
            ),
            
            // Foreground Content
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Unspool your attention.\nReclaim your focus.',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 48),
                  
                  // Primary CTA
                  _isLoading 
                    ? const Center(child: CircularProgressIndicator(color: AppColors.accentGold))
                    : ElevatedButton(
                        onPressed: _signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surfaceDark,
                          foregroundColor: AppColors.textPrimary,
                          side: const BorderSide(color: AppColors.surfaceDark, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Simple 'G' icon representation
                            Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                color: AppColors.textPrimary,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Text(
                                  'G', 
                                  style: TextStyle(
                                    color: AppColors.surfaceDark, 
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14,
                                  )
                                )
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Continue with Google',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThreadPainter extends CustomPainter {
  final double progress;

  _ThreadPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint glowPaint = Paint()
      ..color = AppColors.accentGold.withOpacity(0.2 + (0.3 * progress))
      ..strokeWidth = 4 + (4 * progress)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
      
    final Paint corePaint = Paint()
      ..color = AppColors.accentGoldLight
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Path path = Path();
    // Start from top, slightly curve down like a thread unspooling
    path.moveTo(size.width / 2, 0);
    
    // Add some organic curves to the thread
    path.quadraticBezierTo(
      size.width / 2 + 30 * (1 - progress), 
      size.height * 0.3, 
      size.width / 2 - 10, 
      size.height * 0.5
    );
    path.quadraticBezierTo(
      size.width / 2 - 40 * progress, 
      size.height * 0.7, 
      size.width / 2, 
      size.height
    );

    // Draw the glow then the solid core
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, corePaint);
  }

  @override
  bool shouldRepaint(covariant _ThreadPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
