import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';

/// Screen 20: Profile Page
/// Driver profile with photo, name, vehicle/rating info, and settings menu list.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ── Profile Header Card ──────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.divider, width: 0.5),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.primaryGreenSurface,
                      child: const Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreenSurface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primaryGreen.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: AppColors.primaryGreen,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'KYC Verified',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Driver Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Honda City • MH 02 AB 1234',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      5,
                      (i) => Icon(
                        i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                        color: AppColors.warning,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Stats Row ────────────────────────────────────────
          Row(
            children: [
              _MiniStat(
                icon: Icons.receipt_long_outlined,
                label: 'Rides',
                value: '128',
              ),
              const SizedBox(width: 10),
              _MiniStat(
                icon: Icons.timer_outlined,
                label: 'Hours',
                value: '342',
              ),
              const SizedBox(width: 10),
              _MiniStat(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Earned',
                value: '₹24.5K',
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Menu List ────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider, width: 0.5),
            ),
            child: Column(
              children: [
                _MenuItem(
                  icon: Icons.description_outlined,
                  label: 'Personal Documents',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.personalDocuments),
                ),
                const Divider(height: 1, indent: 56),
                _MenuItem(
                  icon: Icons.directions_car_outlined,
                  label: 'Vehicle Documents',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.vehicleDocuments),
                ),
                const Divider(height: 1, indent: 56),
                _MenuItem(
                  icon: Icons.account_balance_outlined,
                  label: 'Bank Details',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.bankDetails),
                ),
                const Divider(height: 1, indent: 56),
                _MenuItem(
                  icon: Icons.language_rounded,
                  label: 'Language Settings',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 56),
                _MenuItem(
                  icon: Icons.shield_outlined,
                  label: 'Privacy & Security',
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 56),
                _MenuItem(
                  icon: Icons.info_outline_rounded,
                  label: 'About',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _MiniStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider, width: 0.5),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryGreen, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryGreenSurface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primaryGreen, size: 20),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textHint,
      ),
      onTap: onTap,
    );
  }
}
