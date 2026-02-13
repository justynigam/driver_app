import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/upload_box.dart';
import '../../widgets/step_progress_indicator.dart';

/// Screen 10: Aadhaar Card Upload
/// Two upload sections: Front and Back of Aadhaar Card.
class AadhaarUploadScreen extends StatefulWidget {
  const AadhaarUploadScreen({super.key});

  @override
  State<AadhaarUploadScreen> createState() => _AadhaarUploadScreenState();
}

class _AadhaarUploadScreenState extends State<AadhaarUploadScreen> {
  File? _front;
  File? _back;

  bool get _allUploaded => _front != null && _back != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Aadhaar Photos'),
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
            const StepProgressIndicator(currentStep: 6, totalSteps: 10),
            const SizedBox(height: 28),

            const Text(
              'Upload Aadhaar Card',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Take clear photos of both sides of your Aadhaar card.',
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
                    label: 'Front of Aadhaar Card',
                    onFileChanged: (f) => setState(() => _front = f),
                  ),
                  const SizedBox(height: 20),
                  UploadBox(
                    label: 'Back of Aadhaar Card',
                    onFileChanged: (f) => setState(() => _back = f),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            PrimaryButton(
              label: 'Next',
              onPressed: _allUploaded
                  ? () => Navigator.pushNamed(context, AppRoutes.kycVehicleInfo)
                  : null,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
