class Vehicle {
  final String registrationNumber;
  final String make;
  final String model;
  final int year;
  final double value;
  final String usage; // "private", "psv", "commercial"
  final bool hasAntiTheft;
  final bool hasNoClaimDiscount;

  Vehicle({
    required this.registrationNumber,
    required this.make,
    required this.model,
    required this.year,
    required this.value,
    required this.usage,
    this.hasAntiTheft = false,
    this.hasNoClaimDiscount = false,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'registrationNumber': registrationNumber,
      'make': make,
      'model': model,
      'year': year,
      'value': value,
      'usage': usage,
      'hasAntiTheft': hasAntiTheft,
      'hasNoClaimDiscount': hasNoClaimDiscount,
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      registrationNumber: json['registrationNumber'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: json['year'] as int,
      value: (json['value'] as num).toDouble(),
      usage: json['usage'] as String,
      hasAntiTheft: json['hasAntiTheft'] as bool? ?? false,
      hasNoClaimDiscount: json['hasNoClaimDiscount'] as bool? ?? false,
    );
  }

  // Helper method to get vehicle age
  int get age => DateTime.now().year - year;

  // Helper method to get full vehicle name
  String get fullName => '$make $model ($year)';

  @override
  String toString() {
    return 'Vehicle(registrationNumber: $registrationNumber, make: $make, model: $model, year: $year, value: $value, usage: $usage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Vehicle &&
        other.registrationNumber == registrationNumber &&
        other.make == make &&
        other.model == model &&
        other.year == year &&
        other.value == value &&
        other.usage == usage &&
        other.hasAntiTheft == hasAntiTheft &&
        other.hasNoClaimDiscount == hasNoClaimDiscount;
  }

  @override
  int get hashCode {
    return registrationNumber.hashCode ^
        make.hashCode ^
        model.hashCode ^
        year.hashCode ^
        value.hashCode ^
        usage.hashCode ^
        hasAntiTheft.hashCode ^
        hasNoClaimDiscount.hashCode;
  }
}
