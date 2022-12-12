
import 'package:fpdart/fpdart.dart';
import 'package:project_integration_pb/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;