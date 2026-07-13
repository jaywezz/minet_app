import '../models/insurance_company.dart';
import '../models/benefit.dart';

class InsurersData {
  static final List<InsuranceCompany> insurers = [
    InsuranceCompany(
      id: "A1",
      name: "APA Insurance",
      baseRate: 0.045,
      minPremium: 30000,
      supportsComprehensive: true,
      supportsTPO: true,
      benefits: [
        Benefit(
          title: "Road Rescue",
          description: "Free towing and roadside assistance",
        ),
        Benefit(
          title: "Excess Protector",
          description: "Covers excess in case of claim",
        ),
        Benefit(
          title: "24/7 Claims Support",
          description: "Round-the-clock claims assistance",
        ),
      ],
    ),
    InsuranceCompany(
      id: "B1",
      name: "Jubilee Insurance",
      baseRate: 0.05,
      minPremium: 35000,
      supportsComprehensive: true,
      supportsTPO: true,
      benefits: [
        Benefit(
          title: "Courtesy Car",
          description: "Temporary car when yours is in garage",
        ),
        Benefit(
          title: "Emergency Medical",
          description: "Medical cover up to 50,000 KES",
        ),
        Benefit(
          title: "Personal Accident Cover",
          description: "Cover for driver and passengers",
        ),
      ],
    ),
    InsuranceCompany(
      id: "C1",
      name: "CIC Insurance",
      baseRate: 0.042,
      minPremium: 28000,
      supportsComprehensive: true,
      supportsTPO: true,
      benefits: [
        Benefit(
          title: "Windscreen Cover",
          description: "Free windscreen replacement",
        ),
        Benefit(
          title: "Fire & Theft Protection",
          description: "Enhanced protection against fire and theft",
        ),
        Benefit(
          title: "Legal Liability",
          description: "Cover for third-party legal liability",
        ),
      ],
    ),
    InsuranceCompany(
      id: "D1",
      name: "Kenya Orient Insurance",
      baseRate: 0.048,
      minPremium: 32000,
      supportsComprehensive: true,
      supportsTPO: true,
      benefits: [
        Benefit(
          title: "Emergency Repairs",
          description: "Cover for emergency roadside repairs",
        ),
        Benefit(
          title: "Replacement Vehicle",
          description: "Alternative transport during repairs",
        ),
        Benefit(
          title: "Comprehensive Coverage",
          description: "Full protection for your vehicle",
        ),
      ],
    ),
    InsuranceCompany(
      id: "E1",
      name: "UAP Insurance",
      baseRate: 0.046,
      minPremium: 31000,
      supportsComprehensive: true,
      supportsTPO: true,
      benefits: [
        Benefit(
          title: "Cashless Repairs",
          description: "Direct settlement with approved garages",
        ),
        Benefit(
          title: "No Claim Bonus",
          description: "Up to 50% discount for claim-free years",
        ),
        Benefit(
          title: "Family Cover",
          description: "Extended coverage for family members",
        ),
      ],
    ),
  ];

  /// Get insurer by ID
  static InsuranceCompany? getInsurerById(String id) {
    try {
      return insurers.firstWhere((insurer) => insurer.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get insurers that support comprehensive coverage
  static List<InsuranceCompany> getComprehensiveInsurers() {
    return insurers.where((insurer) => insurer.supportsComprehensive).toList();
  }

  /// Get insurers that support TPO (Third Party Only) coverage
  static List<InsuranceCompany> getTPOInsurers() {
    return insurers.where((insurer) => insurer.supportsTPO).toList();
  }

  /// Get insurers sorted by base rate (ascending)
  static List<InsuranceCompany> getInsurersByBaseRate() {
    final sortedInsurers = List<InsuranceCompany>.from(insurers);
    sortedInsurers.sort((a, b) => a.baseRate.compareTo(b.baseRate));
    return sortedInsurers;
  }

  /// Get insurers sorted by minimum premium (ascending)
  static List<InsuranceCompany> getInsurersByMinPremium() {
    final sortedInsurers = List<InsuranceCompany>.from(insurers);
    sortedInsurers.sort((a, b) => a.minPremium.compareTo(b.minPremium));
    return sortedInsurers;
  }
}

