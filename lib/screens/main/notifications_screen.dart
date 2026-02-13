import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

/// Full-screen notifications page showing all driver notifications.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Mark all read',
              style: TextStyle(fontSize: 12, color: AppColors.primaryGreen),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Today ───────────────────────────────────────────
          const _DateHeader(label: 'Today'),
          const SizedBox(height: 8),
          _NotifTile(
            icon: Icons.currency_rupee_rounded,
            color: AppColors.primaryGreen,
            bg: AppColors.primaryGreenSurface,
            title: 'Payment Received',
            subtitle: '₹185 credited for ride #1042',
            time: '2 min ago',
            unread: true,
          ),
          _NotifTile(
            icon: Icons.person_pin_circle_rounded,
            color: AppColors.warning,
            bg: AppColors.warningLight,
            title: 'Rider Waiting',
            subtitle: 'Passenger at pickup point for 3 min',
            time: '5 min ago',
            unread: true,
          ),
          _NotifTile(
            icon: Icons.card_giftcard_rounded,
            color: Colors.purple,
            bg: Colors.purple.shade50,
            title: 'Bonus Earned!',
            subtitle: 'Complete 5 more rides to earn ₹200 bonus reward',
            time: '1 hr ago',
            unread: true,
          ),
          _NotifTile(
            icon: Icons.verified_rounded,
            color: AppColors.primaryGreen,
            bg: AppColors.primaryGreenSurface,
            title: 'Documents Verified',
            subtitle: 'Your KYC documents have been approved successfully',
            time: '3 hrs ago',
            unread: false,
          ),

          const SizedBox(height: 20),

          // ── Yesterday ──────────────────────────────────────
          const _DateHeader(label: 'Yesterday'),
          const SizedBox(height: 8),
          _NotifTile(
            icon: Icons.currency_rupee_rounded,
            color: AppColors.primaryGreen,
            bg: AppColors.primaryGreenSurface,
            title: 'Payment Received',
            subtitle: '₹320 credited for ride #1038',
            time: '12 Feb, 3:15 PM',
            unread: false,
          ),
          _NotifTile(
            icon: Icons.arrow_upward_rounded,
            color: AppColors.error,
            bg: AppColors.errorLight,
            title: 'Withdrawal Successful',
            subtitle: '₹2,000 sent to SBI account ending 4523 via IMPS',
            time: '12 Feb, 6:00 PM',
            unread: false,
          ),
          _NotifTile(
            icon: Icons.star_rounded,
            color: Colors.amber,
            bg: Colors.amber.shade50,
            title: '5-Star Rating',
            subtitle: 'Priya S. gave you a 5-star rating. Keep it up!',
            time: '12 Feb, 11:20 AM',
            unread: false,
          ),

          const SizedBox(height: 20),

          // ── Earlier ────────────────────────────────────────
          const _DateHeader(label: 'Earlier'),
          const SizedBox(height: 8),
          _NotifTile(
            icon: Icons.campaign_rounded,
            color: Colors.blue,
            bg: Colors.blue.shade50,
            title: 'Peak Hours Active',
            subtitle: 'Earn 1.5x during 8-10 AM & 6-8 PM today',
            time: '11 Feb, 8:00 AM',
            unread: false,
          ),
          _NotifTile(
            icon: Icons.currency_rupee_rounded,
            color: AppColors.primaryGreen,
            bg: AppColors.primaryGreenSurface,
            title: 'Bonus Reward',
            subtitle: '₹100 bonus credited for completing 10 rides streak',
            time: '11 Feb, 9:00 PM',
            unread: false,
          ),
          _NotifTile(
            icon: Icons.security_rounded,
            color: Colors.teal,
            bg: Colors.teal.shade50,
            title: 'Safety Alert',
            subtitle: 'Remember to verify OTP before starting the ride',
            time: '10 Feb, 7:30 AM',
            unread: false,
          ),
        ],
      ),
    );
  }
}

class _DateHeader extends StatelessWidget {
  final String label;
  const _DateHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  final IconData icon;
  final Color color, bg;
  final String title, subtitle, time;
  final bool unread;
  const _NotifTile({
    required this.icon,
    required this.color,
    required this.bg,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: unread
            ? AppColors.primaryGreenSurface.withValues(alpha: 0.3)
            : AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: unread
              ? AppColors.primaryGreen.withValues(alpha: 0.2)
              : AppColors.divider,
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: unread
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (unread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
