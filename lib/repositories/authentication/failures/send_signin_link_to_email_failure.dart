class SendSignInLinkToEmailFailure implements Exception {
  const SendSignInLinkToEmailFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SendSignInLinkToEmailFailure.fromCode(String code) {
    switch (code) {
      case 'operation-not-allowed':
        return const SendSignInLinkToEmailFailure(
          'Thrown if anonymous accounts are not enabled.',
        );
      case 'quota-exceeded':
        return const SendSignInLinkToEmailFailure(
          'Sorry but the sign-up quota of our service is exceeded. Please try agian tommorow, or you can contact our supprt.',
        );
      default:
        return const SendSignInLinkToEmailFailure();
    }
  }

  /// The associated error message.
  final String message;
}
