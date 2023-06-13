import 'dart:async';

abstract class UseCase<Type, Params> {
  Future<Stream<Type>> call(Params params);
}
