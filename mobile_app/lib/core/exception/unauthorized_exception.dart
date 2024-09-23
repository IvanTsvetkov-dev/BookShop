class UnauthorizedException implements Exception {
  const UnauthorizedException([this.message]);

  final String? message;

  @override
  String toString() {
    String result = 'Unauthorized';
    if (message is String) return '$message';
    return result;
  }
}
