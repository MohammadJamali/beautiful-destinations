import 'signin_failure.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SendEmailLinkFailure extends SignInFailure implements Exception {
  const SendEmailLinkFailure([
    String message = 'An unknown exception occurred.',
  ]) : super(message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  @override
  factory SendEmailLinkFailure.fromCode(
    String code,
    AppLocalizations localizations,
  ) {
    switch (code) {
      case 'internal-error':
        return SendEmailLinkFailure(
          localizations.failureSignInWithEmailLink,
        );
      default:
        return SignInFailure.fromCode(code, localizations)
            as SendEmailLinkFailure;
    }
  }
}
