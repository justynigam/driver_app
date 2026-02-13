import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';

/// Screen 16: Real-time Ride Requests
/// List of available passenger cards with Accept/Decline actions.
/// Shows a blinking green "Online" dot at the top.
class RideRequestsScreen extends StatefulWidget {
  const RideRequestsScreen({super.key});

  @override
  State<RideRequestsScreen> createState() => _RideRequestsScreenState();
}

class _RideRequestsScreenState extends State<RideRequestsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _blinkAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Ride Requests'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // ── Online Status Banner ────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryGreenSurface,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primaryGreen.withValues(alpha: 0.2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _blinkAnimation,
                  builder: (context, child) => Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withValues(
                        alpha: _blinkAnimation.value,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGreen.withValues(
                            alpha: _blinkAnimation.value * 0.5,
                          ),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'You are Online — Looking for rides',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),

          // ── Ride Request List ───────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _mockRequests.length,
              itemBuilder: (context, index) {
                final req = _mockRequests[index];
                return _RideRequestCard(
                  request: req,
                  onAccept: () {
                    Navigator.pushNamed(context, AppRoutes.activeRidePickup);
                  },
                  onDecline: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ride declined'),
                        backgroundColor: AppColors.textSecondary,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RideRequest {
  final String passengerName;
  final String pickupDistance;
  final String pickupLocation;
  final String dropLocation;
  final String estimatedEarning;

  _RideRequest({
    required this.passengerName,
    required this.pickupDistance,
    required this.pickupLocation,
    required this.dropLocation,
    required this.estimatedEarning,
  });
}

final List<_RideRequest> _mockRequests = [
  _RideRequest(
    passengerName: 'Rahul M.',
    pickupDistance: '800m away',
    pickupLocation: 'MG Road Metro Station',
    dropLocation: 'Koramangala 4th Block',
    estimatedEarning: '₹185',
  ),
  _RideRequest(
    passengerName: 'Priya S.',
    pickupDistance: '1.2 km away',
    pickupLocation: 'Indiranagar 100 Ft Road',
    dropLocation: 'Whitefield Main Road',
    estimatedEarning: '₹320',
  ),
  _RideRequest(
    passengerName: 'Amit K.',
    pickupDistance: '500m away',
    pickupLocation: 'Brigade Road',
    dropLocation: 'Electronic City Phase 1',
    estimatedEarning: '₹410',
  ),
];

class _RideRequestCard extends StatelessWidget {
  final _RideRequest request;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const _RideRequestCard({
    required this.request,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Passenger Info Row ──────────────────────────────
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryGreenSurface,
                child: Text(
                  request.passengerName[0],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.passengerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      request.pickupDistance,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreenSurface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  request.estimatedEarning,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 14),

          // ── Route Info ─────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: AppColors.primaryGreen,
                  ),
                  Container(width: 1, height: 24, color: AppColors.divider),
                  const Icon(
                    Icons.location_on_rounded,
                    size: 14,
                    color: AppColors.error,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.pickupLocation,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      request.dropLocation,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // ── Action Buttons ─────────────────────────────────
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 46,
                  child: OutlinedButton(
                    onPressed: onDecline,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: AppColors.divider),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    onPressed: onAccept,
                    child: const Text('Accept Ride'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
