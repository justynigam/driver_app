import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_colors.dart';
import '../../core/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/step_progress_indicator.dart';

/// Screen 9: Aadhaar Card Information
/// Single form field for Aadhaar number with format validation.
class AadhaarInfoScreen extends StatefulWidget {
  const AadhaarInfoScreen({super.key});

  @override
  State<AadhaarInfoScreen> createState() => _AadhaarInfoScreenState();
}

class _AadhaarInfoScreenState extends State<AadhaarInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aadhaarController = TextEditingController();

  @override
  void dispose() {
    _aadhaarController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, AppRoutes.kycAadhaarUpload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Aadhaar Card'),
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
              const StepProgressIndicator(currentStep: 5, totalSteps: 10),
              const SizedBox(height: 28),

              const Text(
                'Aadhaar Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Enter your 12-digit Aadhaar number for identity verification.',
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
                    // ── Info Note ────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreenSurface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.primaryGreen,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Your Aadhaar details are encrypted and stored securely.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryGreenDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    AppTextField(
                      label: 'Aadhaar Number',
                      hint: 'XXXX XXXX XXXX',
                      controller: _aadhaarController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.credit_card_rounded),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(12),
                        _AadhaarFormatter(),
                      ],
                      validator: (value) {
                        final digits = value?.replaceAll(' ', '') ?? '';
                        if (digits.length != 12) {
                          return 'Enter a valid 12-digit Aadhaar number';
                        }
                        return null;
                      },
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

/// Formats Aadhaar number as XXXX XXXX XXXX.
class _AadhaarFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        buffer.write(' ');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
