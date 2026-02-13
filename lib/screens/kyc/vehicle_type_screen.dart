import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/step_progress_indicator.dart';

/// Screen 5: Choose Vehicle Type
/// Large selectable cards with vehicle type icons. Green highlight on selection.
class VehicleTypeScreen extends StatefulWidget {
  const VehicleTypeScreen({super.key});

  @override
  State<VehicleTypeScreen> createState() => _VehicleTypeScreenState();
}

class _VehicleTypeScreenState extends State<VehicleTypeScreen> {
  int? _selectedIndex;

  final List<_VehicleOption> _vehicles = [
    _VehicleOption('Bike', Icons.two_wheeler_rounded, 'Two-wheeler delivery'),
    _VehicleOption(
      'Auto',
      Icons.electric_rickshaw_rounded,
      'Three-wheeler rides',
    ),
    _VehicleOption(
      'Car - Sedan',
      Icons.directions_car_rounded,
      'Sedan category',
    ),
    _VehicleOption(
      'Car - SUV',
      Icons.directions_car_filled_rounded,
      'SUV / Premium',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Vehicle Type'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Progress ────────────────────────────────────────
            const StepProgressIndicator(currentStep: 1, totalSteps: 10),
            const SizedBox(height: 28),

            const Text(
              'Select your vehicle type',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Choose the type of vehicle you will drive.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // ── Vehicle Cards ───────────────────────────────────
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.95,
                ),
                itemCount: _vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = _vehicles[index];
                  final isSelected = _selectedIndex == index;
                  return _VehicleCard(
                    vehicle: vehicle,
                    isSelected: isSelected,
                    onTap: () => setState(() => _selectedIndex = index),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ── Next Button ─────────────────────────────────────
            PrimaryButton(
              label: 'Next',
              onPressed: _selectedIndex != null
                  ? () =>
                        Navigator.pushNamed(context, AppRoutes.kycPersonalInfo)
                  : null,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _VehicleOption {
  final String name;
  final IconData icon;
  final String subtitle;

  _VehicleOption(this.name, this.icon, this.subtitle);
}

class _VehicleCard extends StatelessWidget {
  final _VehicleOption vehicle;
  final bool isSelected;
  final VoidCallback onTap;

  const _VehicleCard({
    required this.vehicle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreenSurface : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryGreen.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryGreen.withValues(alpha: 0.1)
                    : AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                vehicle.icon,
                size: 36,
                color: isSelected
                    ? AppColors.primaryGreen
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              vehicle.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppColors.primaryGreen
                    : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              vehicle.subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 8),
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primaryGreen,
                size: 22,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
