import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

/// Orders / Ride History Screen
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _mockOrders.length,
      itemBuilder: (context, index) {
        final o = _mockOrders[index];
        return _OrderCard(order: o);
      },
    );
  }
}

class _Order {
  final String date, time, pickup, drop, fare, status, distance;
  _Order({
    required this.date,
    required this.time,
    required this.pickup,
    required this.drop,
    required this.fare,
    required this.status,
    required this.distance,
  });
}

final _mockOrders = [
  _Order(
    date: '10 Feb',
    time: '10:30 AM',
    pickup: 'MG Road Metro',
    drop: 'Koramangala 4th Block',
    fare: '₹185',
    status: 'Completed',
    distance: '8.2 km',
  ),
  _Order(
    date: '09 Feb',
    time: '03:15 PM',
    pickup: 'Indiranagar 100ft Rd',
    drop: 'Whitefield',
    fare: '₹320',
    status: 'Completed',
    distance: '14.5 km',
  ),
  _Order(
    date: '09 Feb',
    time: '11:00 AM',
    pickup: 'Brigade Road',
    drop: 'HSR Layout',
    fare: '₹210',
    status: 'Cancelled',
    distance: '9.8 km',
  ),
  _Order(
    date: '08 Feb',
    time: '08:45 AM',
    pickup: 'Jayanagar',
    drop: 'Majestic',
    fare: '₹150',
    status: 'Completed',
    distance: '6.3 km',
  ),
];

class _OrderCard extends StatelessWidget {
  final _Order order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final ok = order.status == 'Completed';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.date,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${order.time} • ${order.distance}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ok
                          ? AppColors.primaryGreenSurface
                          : AppColors.errorLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: ok ? AppColors.primaryGreen : AppColors.error,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    order.fare,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 8,
                    color: AppColors.primaryGreen,
                  ),
                  Container(width: 1, height: 20, color: AppColors.divider),
                  const Icon(
                    Icons.location_on_rounded,
                    size: 12,
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
                      order.pickup,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      order.drop,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
