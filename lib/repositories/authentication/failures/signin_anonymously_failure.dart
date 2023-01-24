import 'signin_failure.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInAnonymouslyFailure extends SignInFailure implements Exception {
  const SignInAnonymouslyFailure([
    String message = 'An unknown exception occurred.',
  ]) : super(message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  @override
  factory SignInAnonymouslyFailure.fromCode(
    String code,
    AppLocalizations localizations,
  ) {
    switch (code) {
      case 'operation-not-allowed':
        return SignInAnonymouslyFailure(
          localizations.failureAnonymousNotEnabled,
        );
      default:
        return SignInFailure.fromCode(code, localizations)
            as SignInAnonymouslyFailure;
    }
  }
}
