class InvalidValue extends Error {
  final String message;
  InvalidValue(this.message);

  @override
  String toString() {
    return Error.safeToString('Invalid Value : $message');
  }
}
