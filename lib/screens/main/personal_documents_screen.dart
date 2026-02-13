import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

/// Personal Documents Screen — shows driver's uploaded personal documents.
class PersonalDocumentsScreen extends StatelessWidget {
  const PersonalDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Personal Documents'),
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
            // ── Driver's License ────────────────────────────────
            _SectionHeader(
              title: 'Driver\'s License',
              status: 'Verified',
              verified: true,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DocCard(
                    label: 'DL Front',
                    icon: Icons.credit_card_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DocCard(
                    label: 'DL Back',
                    icon: Icons.credit_card_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const _DocCard(
              label: 'Selfie with DL',
              icon: Icons.camera_front_rounded,
            ),
            const SizedBox(height: 8),
            _InfoRow(label: 'DL Number', value: 'MH02 20XXXXXXXX'),
            _InfoRow(label: 'State', value: 'Maharashtra'),
            _InfoRow(label: 'Expiry', value: '15/03/2030'),

            const SizedBox(height: 28),

            // ── Aadhaar Card ────────────────────────────────────
            _SectionHeader(
              title: 'Aadhaar Card',
              status: 'Verified',
              verified: true,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DocCard(
                    label: 'Aadhaar Front',
                    icon: Icons.badge_rounded,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DocCard(
                    label: 'Aadhaar Back',
                    icon: Icons.badge_rounded,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _InfoRow(label: 'Aadhaar Number', value: 'XXXX XXXX 4567'),

            const SizedBox(height: 28),

            // ── Personal Information ────────────────────────────
            _SectionHeader(
              title: 'Personal Information',
              status: 'Complete',
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
                  _InfoRow(label: 'Full Name', value: 'Driver Name'),
                  _InfoRow(label: 'Date of Birth', value: '15/06/1995'),
                  _InfoRow(label: 'Gender', value: 'Male'),
                  _InfoRow(label: 'Phone', value: '+91 98765 43210'),
                  _InfoRow(label: 'City', value: 'Mumbai'),
                  _InfoRow(label: 'Address', value: 'Andheri West, Mumbai'),
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
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
