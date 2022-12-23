class SignInWithEmailLinkFailure implements Exception {
  const SignInWithEmailLinkFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithEmailLinkFailure.fromCode(String code) {
    switch (code) {
      case 'expired-action-code':
        return const SignInWithEmailLinkFailure(
          'Thrown if OTP in email link expires.',
        );
      case 'invalid-email':
        return const SignInWithEmailLinkFailure(
          'Thrown if the email address is not valid.',
        );
      case 'user-disabled':
        return const SignInWithEmailLinkFailure(
          'Thrown if the user corresponding to the given email has been disabled.',
        );
      default:
        return const SignInWithEmailLinkFailure();
    }
  }

  /// The associated error message.
  final String message;
}
