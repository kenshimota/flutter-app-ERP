class AuthErrors {
  final String message;

  AuthErrors({required this.message});

  String getError() {
    return "No tienes session iniciada: $message";
  }
}
