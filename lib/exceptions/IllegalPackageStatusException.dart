class IlleagalPackageStatusException implements Exception {
  String _message;

  IlleagalPackageStatusException(String message) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
