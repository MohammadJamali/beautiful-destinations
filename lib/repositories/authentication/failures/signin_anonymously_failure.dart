class SignInAnonymouslyFailure implements Exception {
  const SignInAnonymouslyFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInAnonymouslyFailure.fromCode(String code) {
    switch (code) {
      case 'operation-not-allowed':
        return const SignInAnonymouslyFailure(
          'Thrown if anonymous accounts are not enabled.',
        );
      default:
        return const SignInAnonymouslyFailure();
    }
  }

  /// The associated error message.
  final String message;
}
