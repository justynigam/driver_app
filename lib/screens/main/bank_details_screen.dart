import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

/// Bank Details & Transaction History Screen
class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _accountNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _confirmAccountController = TextEditingController();
  final _ifscController = TextEditingController();
  final _branchController = TextEditingController();
  final _upiController = TextEditingController();
  final _panController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedBank;
  String _accountType = 'Savings';

  static const _indianBanks = [
    'State Bank of India',
    'HDFC Bank',
    'ICICI Bank',
    'Punjab National Bank',
    'Bank of Baroda',
    'Axis Bank',
    'Canara Bank',
    'Union Bank of India',
    'Bank of India',
    'Indian Bank',
    'Kotak Mahindra Bank',
    'IndusInd Bank',
    'Yes Bank',
    'IDFC First Bank',
    'Federal Bank',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _confirmAccountController.dispose();
    _ifscController.dispose();
    _branchController.dispose();
    _upiController.dispose();
    _panController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Bank Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryGreen,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primaryGreen,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Bank Account'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildBankTab(), _buildHistoryTab()],
      ),
    );
  }

  // ── Bank Account Tab ─────────────────────────────────────
  Widget _buildBankTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Saved Account Card ──────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00A86B), Color(0xFF008A57)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGreen.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_rounded,
                        color: AppColors.white,
                        size: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Primary Account',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      Spacer(),
                      Icon(
                        Icons.verified_rounded,
                        color: Colors.white70,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Verified',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Text(
                    'XXXX XXXX XXXX 4523',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'State Bank of India • Savings',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'IFSC: SBIN0001234 • Branch: Andheri West',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // ── Balance + Withdraw ──────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.divider, width: 0.5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreenSurface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: AppColors.primaryGreen,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '₹2,450.00',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton.icon(
                      onPressed: () => _showWithdrawSheet(context),
                      icon: const Icon(Icons.arrow_upward_rounded, size: 18),
                      label: const Text('Withdraw to Bank / UPI'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ── Quick Withdraw Methods ──────────────────────────
            Row(
              children: [
                _QuickAction(
                  icon: Icons.currency_rupee_rounded,
                  label: 'UPI',
                  onTap: () => _showWithdrawSheet(context, preselect: 'UPI'),
                ),
                const SizedBox(width: 10),
                _QuickAction(
                  icon: Icons.account_balance_rounded,
                  label: 'IMPS',
                  onTap: () => _showWithdrawSheet(context, preselect: 'IMPS'),
                ),
                const SizedBox(width: 10),
                _QuickAction(
                  icon: Icons.swap_horiz_rounded,
                  label: 'NEFT',
                  onTap: () => _showWithdrawSheet(context, preselect: 'NEFT'),
                ),
                const SizedBox(width: 10),
                _QuickAction(
                  icon: Icons.schedule_rounded,
                  label: 'Auto',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 28),
            const Text(
              'Add / Update Bank Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            AppTextField(
              label: 'Account Holder Name',
              hint: 'Full name as per bank passbook',
              controller: _accountNameController,
              prefixIcon: const Icon(Icons.person_outline_rounded),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),

            // ── Bank Name Dropdown ──────────────────────────────
            DropdownButtonFormField<String>(
              value: _selectedBank,
              decoration: const InputDecoration(
                labelText: 'Bank Name',
                prefixIcon: Icon(Icons.account_balance_outlined),
              ),
              hint: const Text('Select your bank'),
              items: _indianBanks
                  .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedBank = v),
              validator: (v) => v == null ? 'Select bank' : null,
            ),
            const SizedBox(height: 16),

            AppTextField(
              label: 'Account Number',
              hint: 'Enter account number',
              controller: _accountNumberController,
              prefixIcon: const Icon(Icons.pin_outlined),
              keyboardType: TextInputType.number,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Confirm Account Number',
              hint: 'Re-enter account number',
              controller: _confirmAccountController,
              prefixIcon: const Icon(Icons.pin_outlined),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (v != _accountNumberController.text)
                  return 'Account numbers do not match';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'IFSC Code',
              hint: 'e.g. SBIN0001234',
              controller: _ifscController,
              prefixIcon: const Icon(Icons.code_rounded),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (v.length != 11) return 'IFSC must be 11 characters';
                return null;
              },
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Branch Name',
              hint: 'e.g. Andheri West',
              controller: _branchController,
              prefixIcon: const Icon(Icons.location_city_outlined),
            ),
            const SizedBox(height: 16),

            // ── Account Type ────────────────────────────────────
            const Text(
              'Account Type',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _AccountTypeChip(
                  label: 'Savings',
                  selected: _accountType == 'Savings',
                  onTap: () => setState(() => _accountType = 'Savings'),
                ),
                const SizedBox(width: 10),
                _AccountTypeChip(
                  label: 'Current',
                  selected: _accountType == 'Current',
                  onTap: () => setState(() => _accountType = 'Current'),
                ),
              ],
            ),

            const SizedBox(height: 16),
            AppTextField(
              label: 'UPI ID (Optional)',
              hint: 'e.g. name@paytm, name@ybl',
              controller: _upiController,
              prefixIcon: const Icon(Icons.currency_rupee_rounded),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'PAN Card Number',
              hint: 'ABCDE1234F',
              controller: _panController,
              prefixIcon: const Icon(Icons.credit_card_outlined),
              validator: (v) {
                if (v == null || v.trim().isEmpty)
                  return 'Required for tax compliance';
                if (v.length != 10) return 'PAN must be 10 characters';
                return null;
              },
            ),

            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Save Bank Details',
              icon: Icons.save_rounded,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bank details saved successfully!'),
                      backgroundColor: AppColors.primaryGreen,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ── Withdraw Bottom Sheet ─────────────────────────────────
  void _showWithdrawSheet(BuildContext context, {String? preselect}) {
    String selectedMethod = preselect ?? 'UPI';
    final amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Withdraw Funds',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Available: ₹2,450.00',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // Method selector
              const Text(
                'Transfer Method',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _MethodChip(
                    label: 'UPI',
                    subtitle: 'Instant',
                    selected: selectedMethod == 'UPI',
                    onTap: () => setSheetState(() => selectedMethod = 'UPI'),
                  ),
                  const SizedBox(width: 8),
                  _MethodChip(
                    label: 'IMPS',
                    subtitle: '< 1 hr',
                    selected: selectedMethod == 'IMPS',
                    onTap: () => setSheetState(() => selectedMethod = 'IMPS'),
                  ),
                  const SizedBox(width: 8),
                  _MethodChip(
                    label: 'NEFT',
                    subtitle: '2-4 hrs',
                    selected: selectedMethod == 'NEFT',
                    onTap: () => setSheetState(() => selectedMethod = 'NEFT'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Amount input
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  prefixText: '₹ ',
                  prefixStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryGreen,
                  ),
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    color: AppColors.textHint.withValues(alpha: 0.5),
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Quick amount buttons
              Row(
                children: ['500', '1,000', '2,000', 'All'].map((amt) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: OutlinedButton(
                        onPressed: () => amountController.text = amt == 'All'
                            ? '2,450'
                            : amt.replaceAll(',', ''),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryGreen,
                          side: const BorderSide(color: AppColors.divider),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: Text(
                          amt == 'All' ? 'All' : '₹$amt',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Withdrawal via $selectedMethod initiated!',
                        ),
                        backgroundColor: AppColors.primaryGreen,
                      ),
                    );
                  },
                  child: Text('Withdraw via $selectedMethod'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── History Tab ──────────────────────────────────────────
  Widget _buildHistoryTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _mockHistory.length,
      itemBuilder: (context, index) {
        final tx = _mockHistory[index];
        final isCredit = tx.type == 'credit';
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider, width: 0.5),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isCredit
                      ? AppColors.primaryGreenSurface
                      : AppColors.errorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isCredit
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  color: isCredit ? AppColors.primaryGreen : AppColors.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tx.date,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${isCredit ? '+' : '-'}${tx.amount}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isCredit ? AppColors.primaryGreen : AppColors.error,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Transaction {
  final String title, date, amount, type;
  _Transaction({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
  });
}

final _mockHistory = [
  _Transaction(
    title: 'Ride Earning',
    date: '13 Feb, 10:30 AM',
    amount: '₹185',
    type: 'credit',
  ),
  _Transaction(
    title: 'Withdrawal to Bank',
    date: '12 Feb, 06:00 PM',
    amount: '₹2,000',
    type: 'debit',
  ),
  _Transaction(
    title: 'Ride Earning',
    date: '12 Feb, 03:15 PM',
    amount: '₹320',
    type: 'credit',
  ),
  _Transaction(
    title: 'Ride Earning',
    date: '12 Feb, 11:00 AM',
    amount: '₹210',
    type: 'credit',
  ),
  _Transaction(
    title: 'Bonus Reward',
    date: '11 Feb, 09:00 PM',
    amount: '₹100',
    type: 'credit',
  ),
  _Transaction(
    title: 'Withdrawal to Bank',
    date: '10 Feb, 05:30 PM',
    amount: '₹1,500',
    type: 'debit',
  ),
  _Transaction(
    title: 'Ride Earning',
    date: '10 Feb, 08:45 AM',
    amount: '₹150',
    type: 'credit',
  ),
];

// ── Helper Widgets ──────────────────────────────────────────

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider, width: 0.5),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primaryGreen, size: 22),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountTypeChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _AccountTypeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryGreen : AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primaryGreen : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: selected ? AppColors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _MethodChip extends StatelessWidget {
  final String label, subtitle;
  final bool selected;
  final VoidCallback onTap;
  const _MethodChip({
    required this.label,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.primaryGreenSurface
                : AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primaryGreen : AppColors.divider,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? AppColors.primaryGreen
                      : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: selected
                      ? AppColors.primaryGreen
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
