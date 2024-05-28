import 'package:flutter/material.dart';

import 'package:privatenotes/screens/emailverify_screen.dart';

import 'package:privatenotes/screens/login_screen.dart';
import 'package:privatenotes/screens/notes_screen.dart';
import 'package:privatenotes/services/auth/auth_services.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthServices.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthServices.firebase().currentUser;
              // log(user.toString());
              // ignore: unnecessary_null_comparison
              if (user != null) {
                if (user.isEmailVerified) {
                  return const NotesScreen();
                } else {
                  return const EmailVerifyScreen();
                }
              } else {
                return const LoginScreen();
              }
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
