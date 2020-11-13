class HandoverClosedException implements Exception {
  String _message;

  HandoverClosedException(String message) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
