import 'benefit.dart';

class InsuranceCompany {
  final String id;
  final String name;
  final double baseRate; // e.g. 0.045 = 4.5%
  final double minPremium; // minimum payable
  final bool supportsComprehensive;
  final bool supportsTPO;
  final List<Benefit> benefits;

  InsuranceCompany({
    required this.id,
    required this.name,
    required this.baseRate,
    required this.minPremium,
    required this.supportsComprehensive,
    required this.supportsTPO,
    required this.benefits,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'baseRate': baseRate,
      'minPremium': minPremium,
      'supportsComprehensive': supportsComprehensive,
      'supportsTPO': supportsTPO,
      'benefits': benefits.map((benefit) => benefit.toJson()).toList(),
    };
  }

  factory InsuranceCompany.fromJson(Map<String, dynamic> json) {
    return InsuranceCompany(
      id: json['id'] as String,
      name: json['name'] as String,
      baseRate: (json['baseRate'] as num).toDouble(),
      minPremium: (json['minPremium'] as num).toDouble(),
      supportsComprehensive: json['supportsComprehensive'] as bool,
      supportsTPO: json['supportsTPO'] as bool,
      benefits: (json['benefits'] as List)
          .map((benefitJson) => Benefit.fromJson(benefitJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'InsuranceCompany(id: $id, name: $name, baseRate: $baseRate, minPremium: $minPremium)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InsuranceCompany &&
        other.id == id &&
        other.name == name &&
        other.baseRate == baseRate &&
        other.minPremium == minPremium &&
        other.supportsComprehensive == supportsComprehensive &&
        other.supportsTPO == supportsTPO;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        baseRate.hashCode ^
        minPremium.hashCode ^
        supportsComprehensive.hashCode ^
        supportsTPO.hashCode;
  }
}
