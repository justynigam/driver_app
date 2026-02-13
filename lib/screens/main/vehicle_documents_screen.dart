import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

/// Vehicle Documents Screen — shows driver's uploaded vehicle documents.
class VehicleDocumentsScreen extends StatelessWidget {
  const VehicleDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Vehicle Documents'),
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
            // ── Vehicle Information ─────────────────────────────
            _SectionHeader(
              title: 'Vehicle Information',
              status: 'Verified',
              verified: true,
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.divider, width: 0.5),
              ),
              child: const Column(
                children: [
                  _InfoRow(label: 'Vehicle Type', value: 'Sedan'),
                  _InfoRow(label: 'Manufacturer', value: 'Honda'),
                  _InfoRow(label: 'Model', value: 'City'),
                  _InfoRow(label: 'License Plate', value: 'MH 02 AB 1234'),
                  _InfoRow(label: 'Registration Year', value: '2022'),
                  _InfoRow(label: 'Color', value: 'White'),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ── Vehicle Photos ──────────────────────────────────
            _SectionHeader(
              title: 'Vehicle Photos',
              status: 'Verified',
              verified: true,
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                _DocCard(
                  label: 'Front View',
                  icon: Icons.directions_car_rounded,
                ),
                _DocCard(
                  label: 'Back View',
                  icon: Icons.directions_car_rounded,
                ),
                _DocCard(
                  label: 'Left Side',
                  icon: Icons.directions_car_rounded,
                ),
                _DocCard(
                  label: 'Right Side',
                  icon: Icons.directions_car_rounded,
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── Registration Certificate ────────────────────────
            _SectionHeader(
              title: 'Registration Certificate (RC)',
              status: 'Verified',
              verified: true,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DocCard(
                    label: 'RC Front',
                    icon: Icons.description_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DocCard(
                    label: 'RC Back',
                    icon: Icons.description_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── Insurance ───────────────────────────────────────
            _SectionHeader(
              title: 'Insurance',
              status: 'Pending',
              verified: false,
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.warningLight, width: 1),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.warningLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: AppColors.warning,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Upload Insurance',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Not uploaded yet',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.upload_file_rounded, size: 18),
                      label: const Text('Upload Now'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryGreen,
                        side: const BorderSide(color: AppColors.primaryGreen),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title, status;
  final bool verified;
  const _SectionHeader({
    required this.title,
    required this.status,
    required this.verified,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: verified
                ? AppColors.primaryGreenSurface
                : AppColors.warningLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                verified ? Icons.check_circle_rounded : Icons.schedule_rounded,
                size: 14,
                color: verified ? AppColors.primaryGreen : AppColors.warning,
              ),
              const SizedBox(width: 4),
              Text(
                status,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: verified ? AppColors.primaryGreen : AppColors.warning,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DocCard extends StatelessWidget {
  final String label;
  final IconData icon;
  const _DocCard({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primaryGreenSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryGreen, size: 28),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
