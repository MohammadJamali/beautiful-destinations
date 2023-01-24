import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInFailure implements Exception {
  const SignInFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInFailure.fromCode(
    String code,
    AppLocalizations localizations,
  ) {
    // LogInWithGoogleFailure
    switch (code) {
      case 'account-exists-with-different-credential':
        return SignInFailure(
          localizations.failureDifferentCredentials,
        );
      case 'too-many-requests':
        return SignInFailure(
          localizations.failureTooManyRequests,
        );
      case 'invalid-credential':
        return SignInFailure(
          localizations.failureExpiredMalformedCredential,
        );
      case 'operation-not-allowed':
        return SignInFailure(
          localizations.failureOperationNotAllowed,
        );
      case 'user-disabled':
        return SignInFailure(
          localizations.failureUserDisabled,
        );
      case 'user-not-found':
        return SignInFailure(
          localizations.failureEmailNotFound,
        );
      case 'wrong-password':
        return SignInFailure(
          localizations.failureIncorrectPassword,
        );
      case 'invalid-verification-code':
        return SignInFailure(
          localizations.failureInvalidVerificationCode,
        );
      case 'invalid-verification-id':
        return SignInFailure(
          localizations.failureInvalidVerificationId,
        );
      // SignInWithEmailAndPasswordFailure
      case 'invalid-email':
        return SignInFailure(
          localizations.failureEmailBadlyFormatted,
        );
      // SignInWithEmailLinkFailure
      case 'expired-action-code':
        return SignInFailure(
          localizations.failureOtpExpired,
        );
      case 'quota-exceeded':
        return SignInFailure(
          localizations.failureQuotaExceeded,
        );
      case 'email-already-in-use':
        return SignInFailure(
          localizations.failureEmailAccountExists,
        );
      case 'weak-password':
        return SignInFailure(
          localizations.failureStrongerPassword,
        );
      default:
        return SignInFailure(
          localizations.failureUnknown,
        );
    }
  }

  /// The associated error message.
  final String message;
}
