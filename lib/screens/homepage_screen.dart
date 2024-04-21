import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privatenotes/firebase_options.dart';
import 'package:privatenotes/screens/emailverify_screen.dart';

import 'package:privatenotes/screens/login_screen.dart';
import 'package:privatenotes/screens/notes_screen.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;

              // ignore: unnecessary_null_comparison
              if (user != null) {
                if (user.emailVerified) {
                  return const NotesScreen();
                } else {
                  return const EmailVerifyScreen();
                }
              } else {
                return const LoginScreen();
              }

            default:
              return const Text("lodaing data ......");
          }
        });
  }
}
