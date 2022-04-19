class CFException implements Exception {
  final bool ressult;
  final String? code;

  CFException({
    required this.ressult,
    required this.code,
  });

  factory CFException.fromJson(Map<String, dynamic> json) {
    return CFException(
      ressult: json['result'],
      code: json['code'],
    );
  }
}
