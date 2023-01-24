import 'dart:async';

import 'package:beautiful_destinations/repositories/authentication/failures/signin_failure.dart';
import 'package:beautiful_destinations/repositories/authentication/models/enums/signin_method.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';
import 'failures/failures.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:beautiful_destinations/repositories/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart' show kIsWeb, visibleForTesting;
import 'package:google_sign_in/google_sign_in.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// Whether or not the current environment is web
  /// Should only be overriden for testing purposes. Otherwise,
  /// defaults to [kIsWeb]
  @visibleForTesting
  bool isWeb = kIsWeb;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [UserModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserModel.empty] if the user is not authenticated.
  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [UserModel.empty] if there is no cached user.
  UserModel get currentUser {
    return _cache.read<UserModel>(key: userCacheKey) ?? UserModel.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({
    required String email,
    required String password,
    required AppLocalizations localizations,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInFailure.fromCode(e.code, localizations);
    } catch (_) {
      throw const SignInFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> signInWithGoogle(AppLocalizations localizations) async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInFailure.fromCode(e.code, localizations);
    } catch (_) {
      throw const SignInFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [SignInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required AppLocalizations localizations,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInFailure.fromCode(e.code, localizations);
    } catch (_) {
      throw const SignInFailure();
    }
  }

  /// Signs in as a guest
  ///
  /// Throws a [SignInAnonymouslyFailure] if an exception occurs.
  Future<void> signInAnonymously(AppLocalizations localizations) async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInAnonymouslyFailure.fromCode(e.code, localizations);
    } catch (_) {
      throw const SignInAnonymouslyFailure();
    }
  }

  /// Signs in with the provided [email] and [emailLink].
  ///
  /// Throws a [SignInFailure] if an exception occurs.
  Future<void> signInWithEmailLink({
    required String email,
    required String emailLink,
    required AppLocalizations localizations,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInFailure.fromCode(e.code, localizations);
    } catch (_) {
      throw const SignInFailure();
    }
  }

  Future<bool> isUserRegistered({
    required String email,
  }) async {
    final signInMethods = await fetchSignInMethodsForEmail(email: email);
    return signInMethods.isNotEmpty;
  }

  Future<List<SignInMethod>> fetchSignInMethodsForEmail({
    required String email,
  }) async {
    final signInMethodsStr =
        await _firebaseAuth.fetchSignInMethodsForEmail(email);

    return signInMethodsStr
        .map((method) => SignInMethodExtension.fromJson(method))
        .where((method) => method != null)
        .map((method) => method!)
        .toList();
  }

  Future<void> sendEmailVerification(AppLocalizations localizations) async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification(
        ActionCodeSettings(
          handleCodeInApp: true,
          androidPackageName: 'demo.beautifuldestinations',
          androidInstallApp: true,
          androidMinimumVersion: "1",
          url: 'https://tourism-app-27c37.firebaseapp.com',
        ),
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInFailure.fromCode(e.code, localizations);
    } catch (_) {
      throw const SignInFailure();
    }
  }

  /// Send signs in link to the provided [email].
  ///
  /// Throws a [SendSignInLinkToEmailFailure] if an exception occurs.
  Future<void> sendSignInLinkToEmail({
    required String email,
    required AppLocalizations localizations,
  }) async {
    try {
      await _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          handleCodeInApp: true,
          // iOSBundleId: 'demo.beautifuldestinations',
          androidPackageName: 'demo.beautifuldestinations',
          androidInstallApp: true,
          androidMinimumVersion: "1",
          url: 'https://tourism-app-27c37.firebaseapp.com',
        ),
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SendEmailLinkFailure.fromCode(e.code, localizations);
    } catch (_) {
      throw const SendEmailLinkFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [UserModel.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      isAnonymous: isAnonymous,
      emailVerified: emailVerified,
    );
  }
}
