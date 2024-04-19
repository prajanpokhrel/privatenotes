import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privatenotes/firebase_options.dart';
import 'package:privatenotes/screens/emailverify_screen.dart';

import 'package:privatenotes/screens/login_screen.dart';

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

              if (user! == null) {
                if (user.emailVerified) {
                  print('email verified');
                } else {
                  return const EmailVerifyScreen();
                }
              } else {
                return const LoginScreen();
              }
              return Text("done");

            default:
              return const Text("lodaing data ......");
          }
        });
  }
}
