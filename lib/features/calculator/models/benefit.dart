class Benefit {
  final String title;
  final String description;

  Benefit({
    required this.title,
    required this.description,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory Benefit.fromJson(Map<String, dynamic> json) {
    return Benefit(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  @override
  String toString() {
    return 'Benefit(title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Benefit &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}
