class ServerFailure extends Error {
  final String errorValue;
  ServerFailure(this.errorValue);

  @override
  String toString() {
    return 'Server Error : $errorValue';
  }
}
