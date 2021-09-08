class UnexpectedValueError extends Error {
  final String valueError;
  UnexpectedValueError(this.valueError);

  String toString() {
    const explain = 'Encountered a valueFailure at an unrecoverable point.';
    return Error.safeToString('$explain Failure was: $valueError');
  }
}
