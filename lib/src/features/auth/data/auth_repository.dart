import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  const AuthRepository(this._auth);

  //getters
  User? get userDetails => _auth.currentUser;
  Stream<User?> get authStateChange => _auth.idTokenChanges();

  //sign-in method
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('Sign in successful');
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('User not found');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password');
      } else {
        log(e.message ?? 'No error occured');
        throw AuthException('An error occured. Please try again later');
      }
    }
  }

  //sign-up method
  Future<User?> signUp(String name, String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('Sign up successful');
      _auth.currentUser!.updateDisplayName(name);
      return result.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? '');
    }
  }

  //sign out method
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}

//providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authRepositoryProvider).authStateChange;
});

final userDetailsProvider = Provider.autoDispose<User?>((ref) {
  return ref.read(authRepositoryProvider).userDetails;
});
