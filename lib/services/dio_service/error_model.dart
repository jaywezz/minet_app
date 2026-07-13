class ErrorModel {
  final String message;
  final int? statusCode;
  final Map<String, List<String>>? errors;

  ErrorModel({
    required this.message,
    this.statusCode,
    this.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>>? errorMap;
    
    if (json['errors'] != null) {
      errorMap = {};
      (json['errors'] as Map<String, dynamic>).forEach((key, value) {
        if (value is List) {
          errorMap![key] = List<String>.from(value.map((e) => e.toString()));
        }
      });
    }

    return ErrorModel(
      message: json['message'] ?? 'An error occurred',
      statusCode: json['status_code'],
      errors: errorMap,
    );
  }

  String get firstError {
    if (errors == null || errors!.isEmpty) return message;
    final firstErrorList = errors!.values.first;
    return firstErrorList.isNotEmpty ? firstErrorList.first : message;
  }

  @override
  String toString() => firstError;
} 