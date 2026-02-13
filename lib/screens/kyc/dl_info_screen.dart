import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/step_progress_indicator.dart';

/// Screen 7: Driver License (DL) Information
/// Form with DL Number, Issuing State, Expiry Date.
class DlInfoScreen extends StatefulWidget {
  const DlInfoScreen({super.key});

  @override
  State<DlInfoScreen> createState() => _DlInfoScreenState();
}

class _DlInfoScreenState extends State<DlInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dlNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  String? _selectedState;

  final List<String> _states = [
    'Andhra Pradesh',
    'Assam',
    'Bihar',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Punjab',
    'Rajasthan',
    'Tamil Nadu',
    'Telangana',
    'Uttar Pradesh',
    'West Bengal',
  ];

  @override
  void dispose() {
    _dlNumberController.dispose();
    _expiryController.dispose();
    super.dispose();
  }

  Future<void> _pickExpiryDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryGreen,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      _expiryController.text =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }

  void _onNext() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.kycDlUpload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Driver License'),
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
              const StepProgressIndicator(currentStep: 3, totalSteps: 10),
              const SizedBox(height: 28),

              const Text(
                'Driver License Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Enter your driving license information.',
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
                      label: 'DL Number',
                      hint: 'e.g. DL-0420110012345',
                      controller: _dlNumberController,
                      prefixIcon: const Icon(Icons.badge_outlined),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Enter DL number'
                          : null,
                    ),
                    const SizedBox(height: 18),

                    DropdownButtonFormField<String>(
                      value: _selectedState,
                      decoration: const InputDecoration(
                        labelText: 'Issuing State',
                        prefixIcon: Icon(Icons.location_on_outlined),
                      ),
                      hint: const Text('Select state'),
                      items: _states.map((state) {
                        return DropdownMenuItem(
                          value: state,
                          child: Text(state),
                        );
                      }).toList(),
                      onChanged: (v) => setState(() => _selectedState = v),
                      validator: (v) =>
                          v == null ? 'Select issuing state' : null,
                    ),
                    const SizedBox(height: 18),

                    AppTextField(
                      label: 'Expiry Date',
                      hint: 'DD/MM/YYYY',
                      controller: _expiryController,
                      readOnly: true,
                      onTap: _pickExpiryDate,
                      prefixIcon: const Icon(Icons.event_outlined),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.textSecondary,
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Select expiry date' : null,
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
