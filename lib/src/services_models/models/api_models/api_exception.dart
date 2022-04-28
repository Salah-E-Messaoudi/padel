// ignore_for_file: non_constant_identifier_names

class APIException implements Exception {
  final String error;
  final String error_descrip;

  APIException({
    required this.error,
    required this.error_descrip,
  });

  factory APIException.fromJson(Map<String, dynamic> json) => APIException(
        error: json['error'],
        error_descrip: json['error_descrip'],
      );
}
