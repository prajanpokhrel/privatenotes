import 'package:privatenotes/services/auth/auth_user.dart';

// create abstract class AuthProvider

abstract class AuthProvider {
  AuthUser? currentUser();
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
