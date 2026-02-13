import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/app_colors.dart';

/// Reusable document/photo upload widget with camera/gallery picker.
/// Shows a dashed border placeholder when empty, and a thumbnail with
/// remove option when an image is selected.
class UploadBox extends StatefulWidget {
  final String label;
  final File? initialFile;
  final void Function(File?) onFileChanged;

  const UploadBox({
    super.key,
    required this.label,
    this.initialFile,
    required this.onFileChanged,
  });

  @override
  State<UploadBox> createState() => _UploadBoxState();
}

class _UploadBoxState extends State<UploadBox> {
  File? _pickedFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _pickedFile = widget.initialFile;
  }

  Future<void> _showPickerSheet() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Upload ${widget.label}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreenSurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.primaryGreen,
                  ),
                ),
                title: const Text('Take a Picture'),
                subtitle: const Text('Use your camera'),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreenSurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.photo_library_rounded,
                    color: AppColors.primaryGreen,
                  ),
                ),
                title: const Text('Choose from Gallery'),
                subtitle: const Text('Select an existing photo'),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );

    if (source == null) return;

    final XFile? xFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1200,
    );

    if (xFile != null) {
      setState(() => _pickedFile = File(xFile.path));
      widget.onFileChanged(_pickedFile);
    }
  }

  void _removeFile() {
    setState(() => _pickedFile = null);
    widget.onFileChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickedFile == null ? _showPickerSheet : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              color: _pickedFile != null
                  ? AppColors.primaryGreenSurface
                  : AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _pickedFile != null
                    ? AppColors.primaryGreen
                    : AppColors.inputBorder,
                width: _pickedFile != null ? 1.5 : 1,
                style: _pickedFile != null
                    ? BorderStyle.solid
                    : BorderStyle.solid,
              ),
            ),
            child: _pickedFile != null
                ? _buildThumbnail()
                : _buildPlaceholder(),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryGreenSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.cloud_upload_outlined,
            color: AppColors.primaryGreen,
            size: 28,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Tap to upload',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryGreen,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Camera or Gallery',
          style: TextStyle(fontSize: 11, color: AppColors.textHint),
        ),
      ],
    );
  }

  Widget _buildThumbnail() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: SizedBox(
            width: double.infinity,
            height: 140,
            child: Image.file(_pickedFile!, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: GestureDetector(
            onTap: _removeFile,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16, color: AppColors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          left: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 14, color: AppColors.white),
                SizedBox(width: 4),
                Text(
                  'Uploaded',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
