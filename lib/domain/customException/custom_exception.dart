class ServerError implements Exception {
  String errorMessage;

  ServerError(this.errorMessage);
}
