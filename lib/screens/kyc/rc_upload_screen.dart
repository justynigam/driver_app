import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/upload_box.dart';
import '../../widgets/step_progress_indicator.dart';

/// Screen 13: Registration Certificate (RC) Upload
/// Two upload boxes for RC Front and Back, plus "Submit for Verification" button.
class RcUploadScreen extends StatefulWidget {
  const RcUploadScreen({super.key});

  @override
  State<RcUploadScreen> createState() => _RcUploadScreenState();
}

class _RcUploadScreenState extends State<RcUploadScreen> {
  File? _rcFront;
  File? _rcBack;
  bool _isSubmitting = false;

  bool get _allUploaded => _rcFront != null && _rcBack != null;

  void _submit() {
    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isSubmitting = false);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.kycStatus,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('RC Upload'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StepProgressIndicator(currentStep: 9, totalSteps: 10),
            const SizedBox(height: 28),

            const Text(
              'Registration Certificate',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Upload clear photos of your vehicle RC document.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider, width: 0.5),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  UploadBox(
                    label: 'Front of RC',
                    onFileChanged: (f) => setState(() => _rcFront = f),
                  ),
                  const SizedBox(height: 20),
                  UploadBox(
                    label: 'Back of RC',
                    onFileChanged: (f) => setState(() => _rcBack = f),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Disclaimer ──────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.warningLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.warning,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Please ensure all documents are clearly visible before submitting.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            PrimaryButton(
              label: 'Submit for Verification',
              isLoading: _isSubmitting,
              icon: Icons.verified_outlined,
              onPressed: _allUploaded ? _submit : null,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
