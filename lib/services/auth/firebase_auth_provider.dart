import 'package:firebase_auth/firebase_auth.dart';
import 'package:privatenotes/services/auth/auth_user.dart';
import 'package:privatenotes/services/auth/auth_exception.dart';

class FirebaseAuthProvider implements AuthProvider {
  Future<AuthUser? Function()> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      // ignore: unnecessary_null_comparison
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  AuthUser? currentUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    }
    throw UnimplementedError();
  }

  @override
  // ignore: override_on_non_overriding_member
  Future<AuthUser> logIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: unused_local_variable
      final user = currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
    throw UnimplementedError();
  }

  @override
  // ignore: override_on_non_overriding_member
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }

    throw UnimplementedError();
  }

  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
    throw UnimplementedError();
  }
}

class AuthProvider {}
