import 'package:dartz/dartz.dart';
import 'package:testing_sdk/domain/invalid_value.dart';

import 'error.dart';

abstract class ObjectValue<T> {
  const ObjectValue();
  Either<InvalidValue, T> get value;

  T getOrCrash() {
    return value.fold(
      (failure) => throw UnexpectedValueError(failure.toString()),
      (r) => r,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ObjectValue<T> && o.value == value;
  }

  String getMessage() {
    return value.fold(
      (l) => l.toString(),
      (r) => 'Valid Value',
    );
  }

  bool isValid() => value.isRight();

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
