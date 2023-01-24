part of 'signin_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.anonymously = false,
    this.otpSingIn = false,
  });

  final bool otpSingIn;
  final bool anonymously;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [email, password, status];

  SignInState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
    bool? anonymously,
    bool? otpSingIn,
  }) {
    return SignInState(
      otpSingIn: otpSingIn ?? this.otpSingIn,
      anonymously: anonymously ?? this.anonymously,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
