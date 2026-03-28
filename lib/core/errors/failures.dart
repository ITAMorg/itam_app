abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Identifiants incorrects');
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Impossible de joindre le serveur');
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super('Une erreur inattendue est survenue');
}