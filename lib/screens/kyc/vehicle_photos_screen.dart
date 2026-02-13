import 'dart:io';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/upload_box.dart';
import '../../widgets/step_progress_indicator.dart';

/// Screen 12: Vehicle Photos
/// Four required upload boxes: Front, Back, Left Side, Right Side.
class VehiclePhotosScreen extends StatefulWidget {
  const VehiclePhotosScreen({super.key});

  @override
  State<VehiclePhotosScreen> createState() => _VehiclePhotosScreenState();
}

class _VehiclePhotosScreenState extends State<VehiclePhotosScreen> {
  File? _front;
  File? _back;
  File? _left;
  File? _right;

  bool get _allUploaded =>
      _front != null && _back != null && _left != null && _right != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Vehicle Photos'),
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
            const StepProgressIndicator(currentStep: 8, totalSteps: 10),
            const SizedBox(height: 28),

            const Text(
              'Vehicle Photos',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Upload clear photos of your vehicle from all angles.',
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
                    label: 'Front View (license plate visible)',
                    onFileChanged: (f) => setState(() => _front = f),
                  ),
                  const SizedBox(height: 20),
                  UploadBox(
                    label: 'Back View',
                    onFileChanged: (f) => setState(() => _back = f),
                  ),
                  const SizedBox(height: 20),
                  UploadBox(
                    label: 'Left Side View',
                    onFileChanged: (f) => setState(() => _left = f),
                  ),
                  const SizedBox(height: 20),
                  UploadBox(
                    label: 'Right Side View',
                    onFileChanged: (f) => setState(() => _right = f),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            PrimaryButton(
              label: 'Next',
              onPressed: _allUploaded
                  ? () => Navigator.pushNamed(context, AppRoutes.kycRcUpload)
                  : null,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
