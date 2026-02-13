import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/upload_box.dart';
import '../../widgets/step_progress_indicator.dart';

/// Screen 8: DL Photo & Selfie Upload
/// Three upload sections: DL Front, DL Back, Selfie holding DL.
class DlUploadScreen extends StatefulWidget {
  const DlUploadScreen({super.key});

  @override
  State<DlUploadScreen> createState() => _DlUploadScreenState();
}

class _DlUploadScreenState extends State<DlUploadScreen> {
  File? _dlFront;
  File? _dlBack;
  File? _selfie;

  bool get _allUploaded =>
      _dlFront != null && _dlBack != null && _selfie != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('DL Photos'),
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
            const StepProgressIndicator(currentStep: 4, totalSteps: 10),
            const SizedBox(height: 28),

            const Text(
              'Upload DL Photos',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Upload clear photos of your Driver License and a selfie.',
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
                    label: 'Front of Driver License',
                    onFileChanged: (f) => setState(() => _dlFront = f),
                  ),
                  const SizedBox(height: 20),
                  UploadBox(
                    label: 'Back of Driver License',
                    onFileChanged: (f) => setState(() => _dlBack = f),
                  ),
                  const SizedBox(height: 20),
                  UploadBox(
                    label: 'Selfie holding your DL',
                    onFileChanged: (f) => setState(() => _selfie = f),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            PrimaryButton(
              label: 'Next',
              onPressed: _allUploaded
                  ? () => Navigator.pushNamed(context, AppRoutes.kycAadhaarInfo)
                  : null,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
