import 'package:privatenotes/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();
  Future<AuthUser> createUser(
      {required String email, required String password});
  AuthUser? get currentUser;
  Future<AuthUser> logIn({required String email, required String password});
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
