class HttpException implements Exception {
  final dynamic message;
  final int statusCode;

  HttpException(this.message, this.statusCode);

  @override
  String toString() {
    return message;
  }
}
