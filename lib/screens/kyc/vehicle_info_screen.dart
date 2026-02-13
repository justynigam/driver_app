import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/step_progress_indicator.dart';

/// Screen 11: Vehicle Information
/// Form with Manufacturer, Model, License Plate, Registration Year.
class VehicleInfoScreen extends StatefulWidget {
  const VehicleInfoScreen({super.key});

  @override
  State<VehicleInfoScreen> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _manufacturerController = TextEditingController();
  final _modelController = TextEditingController();
  final _plateController = TextEditingController();
  String? _selectedYear;

  List<String> get _years {
    final currentYear = DateTime.now().year;
    return List.generate(25, (i) => (currentYear - i).toString());
  }

  @override
  void dispose() {
    _manufacturerController.dispose();
    _modelController.dispose();
    _plateController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_formKey.currentState!.validate() && _selectedYear != null) {
      Navigator.pushNamed(context, AppRoutes.kycVehiclePhotos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Vehicle Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepProgressIndicator(currentStep: 7, totalSteps: 10),
              const SizedBox(height: 28),

              const Text(
                'Vehicle Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Enter your vehicle registration details.',
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
                    AppTextField(
                      label: 'Vehicle Manufacturer',
                      hint: 'e.g. Honda, Maruti, Hyundai',
                      controller: _manufacturerController,
                      prefixIcon: const Icon(Icons.directions_car_outlined),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Enter manufacturer'
                          : null,
                    ),
                    const SizedBox(height: 18),

                    AppTextField(
                      label: 'Vehicle Model',
                      hint: 'e.g. City, Swift, i20',
                      controller: _modelController,
                      prefixIcon: const Icon(Icons.car_repair_outlined),
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? 'Enter model' : null,
                    ),
                    const SizedBox(height: 18),

                    AppTextField(
                      label: 'License Plate Number',
                      hint: 'e.g. MH 02 AB 1234',
                      controller: _plateController,
                      prefixIcon: const Icon(Icons.pin_outlined),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Enter plate number'
                          : null,
                    ),
                    const SizedBox(height: 18),

                    DropdownButtonFormField<String>(
                      value: _selectedYear,
                      decoration: const InputDecoration(
                        labelText: 'Registration Year',
                        prefixIcon: Icon(Icons.calendar_month_outlined),
                      ),
                      hint: const Text('Select year'),
                      items: _years.map((year) {
                        return DropdownMenuItem(value: year, child: Text(year));
                      }).toList(),
                      onChanged: (v) => setState(() => _selectedYear = v),
                      validator: (v) =>
                          v == null ? 'Select registration year' : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              PrimaryButton(label: 'Next', onPressed: _onNext),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
