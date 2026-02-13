import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_text_field.dart';

/// Screen 3: Signup - Confirm Information
/// Form with Mobile Number, Full Name, and City selection.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedCity;
  bool _isLoading = false;

  final List<String> _cities = [
    'Mumbai',
    'Delhi',
    'Bangalore',
    'Hyderabad',
    'Chennai',
    'Kolkata',
    'Pune',
    'Ahmedabad',
    'Jaipur',
    'Lucknow',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your city'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate OTP trigger delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pushNamed(
          context,
          AppRoutes.otpVerification,
          arguments: {'phoneNumber': '+91 ${_phoneController.text}'},
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // ── Header ───────────────────────────────────────
              const Text(
                'Confirm your\ninformation',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'We need a few details to get you started.',
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),

              const SizedBox(height: 32),

              // ── Avatar Placeholder ───────────────────────────
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.background,
                      child: const Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: AppColors.textHint,
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
                          Icons.add,
                          size: 18,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── Full Name ────────────────────────────────────
              AppTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: _nameController,
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.person_outline_rounded),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 18),

              // ── Mobile Number ────────────────────────────────
              AppTextField(
                label: 'Mobile Number',
                hint: 'Enter 10-digit number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🇮🇳', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 6),
                      const Text(
                        '+91',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        margin: const EdgeInsets.only(left: 8),
                        color: AppColors.divider,
                      ),
                    ],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  if (value.trim().length != 10) {
                    return 'Enter a valid 10-digit number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 18),

              // ── City Dropdown ────────────────────────────────
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: const InputDecoration(
                  labelText: 'City',
                  prefixIcon: Icon(Icons.location_city_rounded),
                ),
                hint: const Text('Select your city'),
                items: _cities.map((city) {
                  return DropdownMenuItem(value: city, child: Text(city));
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCity = value);
                },
                validator: (value) {
                  if (value == null) return 'Please select a city';
                  return null;
                },
              ),

              const SizedBox(height: 40),

              // ── Continue Button ──────────────────────────────
              PrimaryButton(
                label: 'Continue',
                isLoading: _isLoading,
                onPressed: _onContinue,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
