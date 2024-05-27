import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;

// creatin class and constructor
@immutable
class AuthUser {
  final bool isEmailVerified;
  const AuthUser({required this.isEmailVerified});

  factory AuthUser.fromFirebase(User user) =>
      AuthUser(isEmailVerified: user.emailVerified);
}
