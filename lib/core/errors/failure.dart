class Failure {
  final String errMessage;
  const Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errMessage});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.errMessage});
}
