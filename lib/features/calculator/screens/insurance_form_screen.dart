import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/calculator_provider.dart';
import 'comparison_screen.dart';

class InsuranceFormScreen extends ConsumerStatefulWidget {
  static const String routeName = 'insurance_form';

  const InsuranceFormScreen({super.key});

  @override
  ConsumerState<InsuranceFormScreen> createState() => _InsuranceFormScreenState();
}

class _InsuranceFormScreenState extends ConsumerState<InsuranceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for form fields
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _registrationController;
  late final TextEditingController _makeController;
  late final TextEditingController _modelController;
  late final TextEditingController _valueController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _registrationController = TextEditingController();
    _makeController = TextEditingController();
    _modelController = TextEditingController();
    _valueController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _registrationController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final calculatorState = ref.watch(calculatorProvider);
    final formData = calculatorState.formData;
    final isLoading = calculatorState.isLoading;
    final error = calculatorState.error;

    // Sync controllers with provider state
    _syncControllersWithState(formData);

    // Listen for successful calculations
    ref.listen<CalculatorState>(calculatorProvider, (previous, next) {
      if (previous?.comparisons == null && next.comparisons != null) {
        // Navigate to comparison screen
        
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Quote Form'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _resetForm(ref),
            tooltip: 'Reset Form',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Error Display
              if (error != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: colorScheme.onErrorContainer,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          error,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: colorScheme.onErrorContainer,
                          size: 20,
                        ),
                        onPressed: () => ref.read(calculatorProvider.notifier).clearError(),
                      ),
                    ],
                  ),
                ),
              ],

              // Client Input Form
              _buildSectionHeader('Client Information', theme),
              const SizedBox(height: 16),
              _buildClientForm(theme, formData, ref),
              
              const SizedBox(height: 32),
              
              // Vehicle Input Form
              _buildSectionHeader('Vehicle Information', theme),
              const SizedBox(height: 16),
              _buildVehicleForm(theme, formData, ref),
              
              const SizedBox(height: 32),
              
              // Calculate Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () => _calculatePremiums(ref),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Calculate Premiums',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildClientForm(ThemeData theme, FormData formData, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter client full name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              onChanged: (value) => ref.read(calculatorProvider.notifier).updateClientName(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter client name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter phone number',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) => ref.read(calculatorProvider.notifier).updateClientPhone(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter email address',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => ref.read(calculatorProvider.notifier).updateClientEmail(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleForm(ThemeData theme, FormData formData, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _registrationController,
              decoration: const InputDecoration(
                labelText: 'Registration Number',
                hintText: 'e.g., KAA 123A',
                prefixIcon: Icon(Icons.directions_car_outlined),
              ),
              onChanged: (value) => ref.read(calculatorProvider.notifier).updateRegistrationNumber(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter registration number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _makeController,
                    decoration: const InputDecoration(
                      labelText: 'Make',
                      hintText: 'e.g., Toyota',
                      prefixIcon: Icon(Icons.business_outlined),
                    ),
                    onChanged: (value) => ref.read(calculatorProvider.notifier).updateMake(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _modelController,
                    decoration: const InputDecoration(
                      labelText: 'Model',
                      hintText: 'e.g., Corolla',
                      prefixIcon: Icon(Icons.model_training_outlined),
                    ),
                    onChanged: (value) => ref.read(calculatorProvider.notifier).updateModel(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: formData.year,
                    decoration: const InputDecoration(
                      labelText: 'Year of Manufacture',
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    items: List.generate(30, (index) {
                      final year = DateTime.now().year - index;
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(calculatorProvider.notifier).updateYear(value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _valueController,
                    decoration: const InputDecoration(
                      labelText: 'Vehicle Value (KES)',
                      hintText: 'e.g., 500000',
                      prefixIcon: Icon(Icons.attach_money_outlined),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      // Only update if the value is not empty and is a valid number
                      if (value.isNotEmpty) {
                        final parsed = double.tryParse(value);
                        if (parsed != null && parsed >= 0) {
                          ref.read(calculatorProvider.notifier).updateValue(parsed);
                        }
                      } else {
                        // If empty, set value to 0
                        ref.read(calculatorProvider.notifier).updateValue(0);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      final parsed = double.tryParse(value);
                      if (parsed == null || parsed <= 0) {
                        return 'Enter valid amount';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: formData.usage,
              decoration: const InputDecoration(
                labelText: 'Usage Type',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: const [
                DropdownMenuItem(value: 'private', child: Text('Private')),
                DropdownMenuItem(value: 'psv', child: Text('PSV (Public Service Vehicle)')),
                DropdownMenuItem(value: 'commercial', child: Text('Commercial')),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(calculatorProvider.notifier).updateUsage(value);
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Has Anti-Theft Device'),
                    value: formData.hasAntiTheft,
                    onChanged: (value) {
                      ref.read(calculatorProvider.notifier).updateHasAntiTheft(value ?? false);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Has No Claim Discount'),
                    value: formData.hasNoClaimDiscount,
                    onChanged: (value) {
                      ref.read(calculatorProvider.notifier).updateHasNoClaimDiscount(value ?? false);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _calculatePremiums(WidgetRef ref) async{
    await ref.read(calculatorProvider.notifier).calculatePremiums();
    context.pushNamed(
          ComparisonScreen.routeName,
          extra: {
            'client': ref.read(calculatorProvider).formData.client,
            'vehicle': ref.read(calculatorProvider).formData.vehicle,
            'comparisons': ref.read(calculatorProvider).comparisons,
          },
        );
  }

  void _syncControllersWithState(FormData formData) {
    // Only update controllers if they're different to avoid cursor jumping
    if (_nameController.text != formData.clientName) {
      _nameController.text = formData.clientName;
    }
    if (_phoneController.text != formData.clientPhone) {
      _phoneController.text = formData.clientPhone;
    }
    if (_emailController.text != formData.clientEmail) {
      _emailController.text = formData.clientEmail;
    }
    if (_registrationController.text != formData.registrationNumber) {
      _registrationController.text = formData.registrationNumber;
    }
    if (_makeController.text != formData.make) {
      _makeController.text = formData.make;
    }
    if (_modelController.text != formData.model) {
      _modelController.text = formData.model;
    }
    // Don't sync value controller to avoid cursor jumping and decimal formatting issues
    // The value will be updated through onChanged callback
  }

  void _resetForm(WidgetRef ref) {
    // Clear provider state
    ref.read(calculatorProvider.notifier).resetForm();
    
    // Clear all controllers
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _registrationController.clear();
    _makeController.clear();
    _modelController.clear();
    _valueController.clear();
    
    // Reset form validation
    _formKey.currentState?.reset();
  }
}
