abstract class Failure {
  final String message;
  final int code;
  final bool retryable;
  final Exception exception;

  Failure({
    required this.message,
    required this.code,
    required this.retryable,
    required this.exception,
  });
}
