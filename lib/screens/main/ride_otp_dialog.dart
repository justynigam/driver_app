import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';

/// Screen 18: OTP Start Verification Popup
/// Modal dialog requesting the 4-digit PIN from passenger to start the trip.
void showRideOtpDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => const _RideOtpDialog(),
  );
}

class _RideOtpDialog extends StatefulWidget {
  const _RideOtpDialog();

  @override
  State<_RideOtpDialog> createState() => _RideOtpDialogState();
}

class _RideOtpDialogState extends State<_RideOtpDialog> {
  final _controller = TextEditingController();
  bool _isVerifying = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _verify(String pin) {
    if (pin.length != 4) return;

    setState(() {
      _isVerifying = true;
      _error = null;
    });

    // Simulate verification
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.pop(context); // Close dialog
        Navigator.pushReplacementNamed(context, AppRoutes.activeRideTransit);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Icon ─────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryGreenSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.pin_rounded,
                color: AppColors.primaryGreen,
                size: 32,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Enter Ride PIN',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ask the passenger for the 4-digit\nPIN to start the trip.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 24),

            // ── PIN Input ────────────────────────────────────
            PinCodeTextField(
              appContext: context,
              length: 4,
              controller: _controller,
              autoFocus: true,
              keyboardType: TextInputType.number,
              animationType: AnimationType.scale,
              animationDuration: const Duration(milliseconds: 200),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 56,
                fieldWidth: 56,
                activeColor: AppColors.primaryGreen,
                inactiveColor: AppColors.inputBorder,
                selectedColor: AppColors.primaryGreen,
                activeFillColor: AppColors.primaryGreenSurface,
                inactiveFillColor: AppColors.background,
                selectedFillColor: AppColors.white,
                borderWidth: 1.5,
              ),
              enableActiveFill: true,
              onCompleted: _verify,
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),

            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(fontSize: 12, color: AppColors.error),
              ),
            ],

            const SizedBox(height: 16),

            if (_isVerifying)
              const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(AppColors.primaryGreen),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          side: const BorderSide(color: AppColors.divider),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () => _verify(_controller.text),
                        child: const Text('Verify'),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
