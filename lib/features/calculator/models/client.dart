class Client {
  final String fullName;
  final String phoneNumber;
  final String email;

  Client({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
    );
  }

  @override
  String toString() {
    return 'Client(fullName: $fullName, phoneNumber: $phoneNumber, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Client &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.email == email;
  }

  @override
  int get hashCode => fullName.hashCode ^ phoneNumber.hashCode ^ email.hashCode;
}
