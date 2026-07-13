import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/calculator_repository.dart';
import '../models/client.dart';
import '../models/vehicle.dart';
import '../models/insurance_company.dart';
import '../services/premium_calculator.dart';
import '../data/insurers_data.dart';

// Repository provider
final calculatorRepositoryProvider = Provider<CalculatorRepository>((ref) {
  return MockCalculatorRepository();
});

// Form data state
class FormData {
  // Client fields
  final String clientName;
  final String clientPhone;
  final String clientEmail;
  
  // Vehicle fields
  final String registrationNumber;
  final String make;
  final String model;
  final int year;
  final double value;
  final String usage;
  final bool hasAntiTheft;
  final bool hasNoClaimDiscount;

  const FormData({
    this.clientName = '',
    this.clientPhone = '',
    this.clientEmail = '',
    this.registrationNumber = '',
    this.make = '',
    this.model = '',
    this.year = 2024,
    this.value = 0.0,
    this.usage = 'private',
    this.hasAntiTheft = false,
    this.hasNoClaimDiscount = false,
  });

  FormData copyWith({
    String? clientName,
    String? clientPhone,
    String? clientEmail,
    String? registrationNumber,
    String? make,
    String? model,
    int? year,
    double? value,
    String? usage,
    bool? hasAntiTheft,
    bool? hasNoClaimDiscount,
  }) {
    return FormData(
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      clientEmail: clientEmail ?? this.clientEmail,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      value: value ?? this.value,
      usage: usage ?? this.usage,
      hasAntiTheft: hasAntiTheft ?? this.hasAntiTheft,
      hasNoClaimDiscount: hasNoClaimDiscount ?? this.hasNoClaimDiscount,
    );
  }

  // Validation methods
  bool get isClientDataValid {
    return clientName.isNotEmpty && 
           clientPhone.isNotEmpty && 
           clientEmail.isNotEmpty && 
           clientEmail.contains('@');
  }

  bool get isVehicleDataValid {
    return registrationNumber.isNotEmpty && 
           make.isNotEmpty && 
           model.isNotEmpty && 
           value > 0;
  }

  bool get isFormValid => isClientDataValid && isVehicleDataValid;

  // Convert to model objects
  Client get client => Client(
    fullName: clientName,
    phoneNumber: clientPhone,
    email: clientEmail,
  );

  Vehicle get vehicle => Vehicle(
    registrationNumber: registrationNumber,
    make: make,
    model: model,
    year: year,
    value: value,
    usage: usage,
    hasAntiTheft: hasAntiTheft,
    hasNoClaimDiscount: hasNoClaimDiscount,
  );
}

// Calculator state
class CalculatorState {
  final FormData formData;
  final bool isLoading;
  final String? error;
  final List<InsurerComparison>? comparisons;

  const CalculatorState({
    this.formData = const FormData(),
    this.isLoading = false,
    this.error,
    this.comparisons,
  });

  CalculatorState copyWith({
    FormData? formData,
    bool? isLoading,
    String? error,
    List<InsurerComparison>? comparisons,
  }) {
    return CalculatorState(
      formData: formData ?? this.formData,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      comparisons: comparisons ?? this.comparisons,
    );
  }
}

// Calculator notifier
class CalculatorNotifier extends StateNotifier<CalculatorState> {
  CalculatorNotifier() : super(const CalculatorState());

  // Form field updates
  void updateClientName(String name) {
    state = state.copyWith(
      formData: state.formData.copyWith(clientName: name),
      error: null,
    );
  }

  void updateClientPhone(String phone) {
    state = state.copyWith(
      formData: state.formData.copyWith(clientPhone: phone),
      error: null,
    );
  }

  void updateClientEmail(String email) {
    state = state.copyWith(
      formData: state.formData.copyWith(clientEmail: email),
      error: null,
    );
  }

  void updateRegistrationNumber(String registration) {
    state = state.copyWith(
      formData: state.formData.copyWith(registrationNumber: registration),
      error: null,
    );
  }

  void updateMake(String make) {
    state = state.copyWith(
      formData: state.formData.copyWith(make: make),
      error: null,
    );
  }

  void updateModel(String model) {
    state = state.copyWith(
      formData: state.formData.copyWith(model: model),
      error: null,
    );
  }

  void updateYear(int year) {
    state = state.copyWith(
      formData: state.formData.copyWith(year: year),
      error: null,
    );
  }

  void updateValue(double value) {
    state = state.copyWith(
      formData: state.formData.copyWith(value: value),
      error: null,
    );
  }

  void updateUsage(String usage) {
    state = state.copyWith(
      formData: state.formData.copyWith(usage: usage),
      error: null,
    );
  }

  void updateHasAntiTheft(bool hasAntiTheft) {
    state = state.copyWith(
      formData: state.formData.copyWith(hasAntiTheft: hasAntiTheft),
      error: null,
    );
  }

  void updateHasNoClaimDiscount(bool hasNoClaimDiscount) {
    state = state.copyWith(
      formData: state.formData.copyWith(hasNoClaimDiscount: hasNoClaimDiscount),
      error: null,
    );
  }

  // Calculate premiums
  Future<void> calculatePremiums() async {
    if (!state.formData.isFormValid) {
      state = state.copyWith(
        error: 'Please fill in all required fields correctly',
      );
      return;
    }

    try {
      state = state.copyWith(isLoading: true, error: null);

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Calculate premiums for all insurers
      final comparisons = <InsurerComparison>[];
      
      for (final insurer in InsurersData.insurers) {
        final premium = PremiumCalculator.calculatePremium(insurer, state.formData.vehicle);
        comparisons.add(InsurerComparison(
          insurer: insurer,
          premium: premium,
        ));
      }
      
      // Sort by premium (ascending)
      comparisons.sort((a, b) => a.premium.compareTo(b.premium));

      state = state.copyWith(
        isLoading: false,
        comparisons: comparisons,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to calculate premiums: ${e.toString()}',
      );
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void resetForm() {
    state = const CalculatorState();
  }

  void clearComparisons() {
    state = state.copyWith(comparisons: null);
  }
}

// Calculator provider
final calculatorProvider = StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
});

// Convenience providers
final formDataProvider = Provider<FormData>((ref) {
  return ref.watch(calculatorProvider).formData;
});

final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(calculatorProvider).isLoading;
});

final errorProvider = Provider<String?>((ref) {
  return ref.watch(calculatorProvider).error;
});

final comparisonsProvider = Provider<List<InsurerComparison>?>((ref) {
  return ref.watch(calculatorProvider).comparisons;
});

// Insurer comparison model
class InsurerComparison {
  final InsuranceCompany insurer;
  final double premium;

  InsurerComparison({
    required this.insurer,
    required this.premium,
  });
}
