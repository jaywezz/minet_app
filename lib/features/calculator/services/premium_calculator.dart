import '../models/insurance_company.dart';
import '../models/vehicle.dart';

class PremiumCalculator {
  /// Calculate premium for a given insurer and vehicle
  static double calculatePremium(InsuranceCompany insurer, Vehicle vehicle) {
    // Step 1: Base premium
    double premium = vehicle.value * insurer.baseRate;
    if (premium < insurer.minPremium) premium = insurer.minPremium;

    // Step 2: Loadings
    if (vehicle.usage == "psv") premium *= 1.5;
    else if (vehicle.usage == "commercial") premium *= 1.2;

    int age = vehicle.age;
    if (age >= 8 && age <= 15) premium *= 1.2;
    else if (age > 15) premium *= 1.5;

    // Step 3: Discounts
    if (vehicle.hasNoClaimDiscount) premium *= 0.9;
    if (vehicle.hasAntiTheft) premium *= 0.95;

    return premium;
  }

  /// Calculate premium with detailed breakdown
  static PremiumBreakdown calculatePremiumBreakdown(InsuranceCompany insurer, Vehicle vehicle) {
    double basePremium = vehicle.value * insurer.baseRate;
    double adjustedPremium = basePremium;
    
    if (adjustedPremium < insurer.minPremium) {
      adjustedPremium = insurer.minPremium;
    }

    // Calculate loadings
    double usageLoading = 0.0;
    if (vehicle.usage == "psv") {
      usageLoading = adjustedPremium * 0.5; // 50% loading
      adjustedPremium *= 1.5;
    } else if (vehicle.usage == "commercial") {
      usageLoading = adjustedPremium * 0.2; // 20% loading
      adjustedPremium *= 1.2;
    }

    double ageLoading = 0.0;
    int age = vehicle.age;
    if (age >= 8 && age <= 15) {
      ageLoading = adjustedPremium * 0.2; // 20% loading
      adjustedPremium *= 1.2;
    } else if (age > 15) {
      ageLoading = adjustedPremium * 0.5; // 50% loading
      adjustedPremium *= 1.5;
    }

    // Calculate discounts
    double noClaimDiscount = 0.0;
    if (vehicle.hasNoClaimDiscount) {
      noClaimDiscount = adjustedPremium * 0.1; // 10% discount
      adjustedPremium *= 0.9;
    }

    double antiTheftDiscount = 0.0;
    if (vehicle.hasAntiTheft) {
      antiTheftDiscount = adjustedPremium * 0.05; // 5% discount
      adjustedPremium *= 0.95;
    }

    return PremiumBreakdown(
      basePremium: basePremium,
      minPremium: insurer.minPremium,
      usageLoading: usageLoading,
      ageLoading: ageLoading,
      noClaimDiscount: noClaimDiscount,
      antiTheftDiscount: antiTheftDiscount,
      finalPremium: adjustedPremium,
    );
  }
}

class PremiumBreakdown {
  final double basePremium;
  final double minPremium;
  final double usageLoading;
  final double ageLoading;
  final double noClaimDiscount;
  final double antiTheftDiscount;
  final double finalPremium;

  PremiumBreakdown({
    required this.basePremium,
    required this.minPremium,
    required this.usageLoading,
    required this.ageLoading,
    required this.noClaimDiscount,
    required this.antiTheftDiscount,
    required this.finalPremium,
  });

  /// Get all applicable adjustments
  List<PremiumAdjustment> get adjustments {
    List<PremiumAdjustment> adjustments = [];
    
    if (usageLoading > 0) {
      adjustments.add(PremiumAdjustment(
        type: 'Usage Loading',
        amount: usageLoading,
        isDiscount: false,
      ));
    }
    
    if (ageLoading > 0) {
      adjustments.add(PremiumAdjustment(
        type: 'Age Loading',
        amount: ageLoading,
        isDiscount: false,
      ));
    }
    
    if (noClaimDiscount > 0) {
      adjustments.add(PremiumAdjustment(
        type: 'No Claim Discount',
        amount: noClaimDiscount,
        isDiscount: true,
      ));
    }
    
    if (antiTheftDiscount > 0) {
      adjustments.add(PremiumAdjustment(
        type: 'Anti-Theft Discount',
        amount: antiTheftDiscount,
        isDiscount: true,
      ));
    }
    
    return adjustments;
  }
}

class PremiumAdjustment {
  final String type;
  final double amount;
  final bool isDiscount;

  PremiumAdjustment({
    required this.type,
    required this.amount,
    required this.isDiscount,
  });
}
