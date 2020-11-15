class NotFoundException implements Exception {
  String _message;

  NotFoundException(String message) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
