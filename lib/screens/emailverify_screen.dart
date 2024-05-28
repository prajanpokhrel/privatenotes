import 'package:flutter/material.dart';
import 'package:privatenotes/constant/routes.dart';
import 'package:privatenotes/services/auth/auth_services.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email verify'),
      ),
      body: Column(
        children: [
          const Text(
              "we sent you an email verification . please open it to verify your account"),
          const Text(
              "if you did not receive the email then press the button below"),
          TextButton(
            onPressed: () async {
              await AuthServices.firebase().sendEmailVerification();
            },
            child: const Text("send email verfication"),
          ),
          TextButton(
            onPressed: () async {
              await AuthServices.firebase().logOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}
