import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerifyScreen extends StatelessWidget {
  const EmailVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email verify'),
      ),
      body: Column(
        children: [
          const Text("please verify your email address"),
          TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text("send email verfication"))
        ],
      ),
    );
  }
}
