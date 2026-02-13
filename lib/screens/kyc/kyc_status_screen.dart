import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';

/// Screen 14: KYC Verification Status (Blocking Screen)
/// Four states: Analyzing, Pending, Approved, Rejected.
class KycStatusScreen extends StatefulWidget {
  const KycStatusScreen({super.key});

  @override
  State<KycStatusScreen> createState() => _KycStatusScreenState();
}

enum KycState { analyzing, pending, approved, rejected }

class _KycStatusScreenState extends State<KycStatusScreen>
    with SingleTickerProviderStateMixin {
  KycState _state = KycState.analyzing;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // Simulate analysis → approved flow for demo
    Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _state = KycState.approved);
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildStatusIcon(),
              const SizedBox(height: 32),
              _buildStatusText(),
              const Spacer(),
              _buildAction(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    switch (_state) {
      case KycState.analyzing:
        return AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.9 + (_pulseController.value * 0.1),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreenSurface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGreen.withValues(
                        alpha: 0.2 + (_pulseController.value * 0.1),
                      ),
                      blurRadius: 20 + (_pulseController.value * 10),
                    ),
                  ],
                ),
                child: const Center(
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation(
                        AppColors.primaryGreen,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );

      case KycState.pending:
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.warningLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.schedule_rounded,
            size: 56,
            color: AppColors.warning,
          ),
        );

      case KycState.approved:
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreenSurface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryGreen.withValues(alpha: 0.25),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 64,
                  color: AppColors.primaryGreen,
                ),
              ),
            );
          },
        );

      case KycState.rejected:
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.errorLight,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.cancel_rounded,
            size: 64,
            color: AppColors.error,
          ),
        );
    }
  }

  Widget _buildStatusText() {
    switch (_state) {
      case KycState.analyzing:
        return Column(
          children: [
            const Text(
              'Analyzing your documents...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please do not close the app.\nThis may take a moment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        );

      case KycState.pending:
        return Column(
          children: [
            const Text(
              'Verification Pending',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Our team is manually reviewing your documents\nbased on admin criteria.\nThis may take up to 24 hours.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        );

      case KycState.approved:
        return Column(
          children: [
            const Text(
              'You are approved! 🎉',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryGreen,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Congratulations! Your documents have been verified.\nYou can now start accepting rides.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        );

      case KycState.rejected:
        return Column(
          children: [
            const Text(
              'Verification Failed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Some of your documents could not be verified.\nPlease re-upload clear and valid documents.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        );
    }
  }

  Widget _buildAction() {
    switch (_state) {
      case KycState.analyzing:
        return const SizedBox.shrink();

      case KycState.pending:
        return PrimaryButton(
          label: 'Check Status',
          isOutlined: true,
          onPressed: () {
            // Simulate check → approved
            setState(() => _state = KycState.approved);
          },
        );

      case KycState.approved:
        return PrimaryButton(
          label: 'Go to Homepage',
          icon: Icons.arrow_forward_rounded,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.mainApp,
              (route) => false,
            );
          },
        );

      case KycState.rejected:
        return PrimaryButton(
          label: 'Re-upload Documents',
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.kycVehicleType,
              (route) => false,
            );
          },
        );
    }
  }
}
