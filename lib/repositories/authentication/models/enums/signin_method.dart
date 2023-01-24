enum SignInMethod {
  /// Indicates that the user can sign in with a password.
  password,

  /// Indicates that the user can sign in with their Google account.
  google,

  /// Indicates that the user can sign in with their Facebook account.
  facebook,

  /// Indicates that the user can sign in with their Twitter account.
  twitter,

  /// Indicates that the user can sign in with their GitHub account.
  github,

  /// Indicates that the user can sign in with their phone number.
  phone,
}

extension SignInMethodExtension on SignInMethod {
  /// Converts a string to the corresponding [SignInMethod] value.
  ///
  /// Returns `null` if the string is not a valid sign-in method.
  static SignInMethod? fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'password':
        return SignInMethod.password;
      case 'google.com':
        return SignInMethod.google;
      case 'facebook.com':
        return SignInMethod.facebook;
      case 'twitter.com':
        return SignInMethod.twitter;
      case 'github.com':
        return SignInMethod.github;
      case 'phone':
        return SignInMethod.phone;
      default:
        return null;
    }
  }
}
