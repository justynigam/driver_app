import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';

/// Screen 4: OTP Verification
/// 6-digit PIN input with auto-submit, resend timer, and verification state.
class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  bool _isVerifying = false;
  int _resendSeconds = 30;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _resendSeconds = 30;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  void _verifyOtp(String otp) {
    if (otp.length != 6) return;

    setState(() => _isVerifying = true);

    // Simulate verification
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isVerifying = false);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.kycVehicleType,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // ── Header ─────────────────────────────────────────
            const Text(
              'Verify your\nphone number',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(text: 'Enter the 6-digit code sent to\n'),
                  TextSpan(
                    text: widget.phoneNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ── OTP Input ──────────────────────────────────────
            PinCodeTextField(
              appContext: context,
              length: 6,
              controller: _otpController,
              autoFocus: true,
              keyboardType: TextInputType.number,
              animationType: AnimationType.scale,
              animationDuration: const Duration(milliseconds: 200),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 56,
                fieldWidth: 48,
                activeColor: AppColors.primaryGreen,
                inactiveColor: AppColors.inputBorder,
                selectedColor: AppColors.primaryGreen,
                activeFillColor: AppColors.primaryGreenSurface,
                inactiveFillColor: AppColors.white,
                selectedFillColor: AppColors.white,
                borderWidth: 1.5,
              ),
              enableActiveFill: true,
              onCompleted: _verifyOtp,
              onChanged: (_) {},
            ),

            const SizedBox(height: 24),

            // ── Resend Timer ───────────────────────────────────
            Center(
              child: _resendSeconds > 0
                  ? RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          const TextSpan(text: 'Resend code in '),
                          TextSpan(
                            text:
                                '00:${_resendSeconds.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        _startResendTimer();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('OTP resent successfully'),
                            backgroundColor: AppColors.primaryGreen,
                          ),
                        );
                      },
                      child: const Text(
                        'Resend Code',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
            ),

            const Spacer(),

            // ── Verify Button ──────────────────────────────────
            PrimaryButton(
              label: 'Verify',
              isLoading: _isVerifying,
              onPressed: () => _verifyOtp(_otpController.text),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
