import 'dart:math';

import 'package:beautiful_destinations/app/authentication/widgets/form_inputs/formz/email.dart';
import 'package:beautiful_destinations/app/authentication/widgets/form_inputs/formz/password.dart';
import 'package:beautiful_destinations/repositories/authentication/failures/failures.dart';
import 'package:beautiful_destinations/repositories/authentication/failures/signin_failure.dart';
import 'package:beautiful_destinations/repositories/authentication/models/enums/signin_method.dart';
import 'package:beautiful_destinations/repositories/authentication/repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    this.authenticationRepository,
    this.localizations,
  ) : super(const SignInState());

  final AppLocalizations localizations;
  final AuthenticationRepository authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> sendEmailVerification() async {
    final z = await authenticationRepository.fetchSignInMethodsForEmail(
        email: authenticationRepository.currentUser.email!);
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.sendEmailVerification(localizations);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SendEmailLinkFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> sendSignInLinkToEmail() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.sendSignInLinkToEmail(
        email: state.email.value,
        localizations: localizations,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SendEmailLinkFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> signInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final methods = await authenticationRepository.fetchSignInMethodsForEmail(
      email: state.email.value,
    );
    if (methods.isEmpty) {
      // not registered
      await authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
        localizations: localizations,
      );
    } else if (!methods.contains(SignInMethod.password)) {
      emit(
        state.copyWith(
          errorMessage: 'Login with credentials is not allowed for this email.',
          status: FormzStatus.submissionFailure,
        ),
      );
      return;
    }

    try {
      await authenticationRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
        localizations: localizations,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> signInAnonymously() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.signInAnonymously(localizations);
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          anonymously: true,
        ),
      );
    } on SignInAnonymouslyFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await authenticationRepository.signInWithGoogle(localizations);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignInFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
