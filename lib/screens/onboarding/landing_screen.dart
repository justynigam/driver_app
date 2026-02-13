import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';

/// Screen 2: Landing / Login & Signup
/// Welcome screen with tagline illustration, Login and Sign Up buttons.
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // ── Welcome Illustration ───────────────────────────
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreenSurface,
                  borderRadius: BorderRadius.circular(110),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.directions_car_rounded,
                      size: 80,
                      color: AppColors.primaryGreen.withValues(alpha: 0.3),
                    ),
                    const Icon(
                      Icons.person_rounded,
                      size: 64,
                      color: AppColors.primaryGreen,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── Tagline ────────────────────────────────────────
              const Text(
                'Drive with\nConfidence',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.15,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Join thousands of professional drivers.\nEarn on your own terms.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 2),

              // ── Buttons ────────────────────────────────────────
              PrimaryButton(
                label: 'Sign Up / Register',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
              ),
              const SizedBox(height: 14),
              PrimaryButton(
                label: 'Login',
                isOutlined: true,
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
              ),
              const SizedBox(height: 24),

              // ── Terms ──────────────────────────────────────────
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                  children: [
                    const TextSpan(text: 'By continuing, you agree to our '),
                    TextSpan(
                      text: 'Terms of Use',
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(text: '\nand '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
