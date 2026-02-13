import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/step_progress_indicator.dart';

/// Screen 6: Personal Information
/// Form with DOB, Gender, Address, Alternate Phone Number.
class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  final _altPhoneController = TextEditingController();
  String? _selectedGender;

  @override
  void dispose() {
    _dobController.dispose();
    _addressController.dispose();
    _altPhoneController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
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
      _dobController.text =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }

  void _onNext() {
    if (_formKey.currentState!.validate() && _selectedGender != null) {
      Navigator.pushNamed(context, AppRoutes.kycDlInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Personal Information'),
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
              const StepProgressIndicator(currentStep: 2, totalSteps: 10),
              const SizedBox(height: 28),

              const Text(
                'Personal Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Provide your personal details for verification.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),

              // ── Date of Birth ──────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider, width: 0.5),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      label: 'Date of Birth',
                      hint: 'DD/MM/YYYY',
                      controller: _dobController,
                      readOnly: true,
                      onTap: _pickDate,
                      prefixIcon: const Icon(Icons.calendar_today_rounded),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.textSecondary,
                      ),
                      validator: (v) => v == null || v.isEmpty
                          ? 'Select date of birth'
                          : null,
                    ),
                    const SizedBox(height: 18),

                    // ── Gender ──────────────────────────────────
                    const Text(
                      'Gender',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: ['Male', 'Female', 'Other'].map((gender) {
                        final isSelected = _selectedGender == gender;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: gender != 'Other' ? 10 : 0,
                            ),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedGender = gender),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryGreenSurface
                                      : AppColors.background,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primaryGreen
                                        : AppColors.divider,
                                    width: isSelected ? 1.5 : 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    gender,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? AppColors.primaryGreen
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 18),

                    // ── Address ──────────────────────────────────
                    AppTextField(
                      label: 'Current Residential Address',
                      hint: 'Enter your full address',
                      controller: _addressController,
                      maxLines: 2,
                      prefixIcon: const Icon(Icons.home_outlined),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Enter address'
                          : null,
                    ),

                    const SizedBox(height: 18),

                    // ── Alternate Phone ─────────────────────────
                    AppTextField(
                      label: 'Alternate Phone Number',
                      hint: 'Optional',
                      controller: _altPhoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_outlined),
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
