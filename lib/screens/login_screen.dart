import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:privatenotes/constant/routes.dart';
import 'package:privatenotes/services/auth/auth_exception.dart';
import 'package:privatenotes/services/auth/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _obscureText = true;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                controller: _email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Email"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                enableSuggestions: false,
                obscureText: _obscureText,
                controller: _password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 150,
              margin: EdgeInsets.only(right: 8, left: 8),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 147, 84, 184),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    // ignore: unused_local_variable
                    await AuthServices.firebase()
                        .logIn(email: email, password: password);
                    final user = AuthServices.firebase().currentUser;
                    if (user?.isEmailVerified ?? false) {
                      //user email  verified
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(noteRoute, (route) => false);
                    } else {
                      //user email not verified
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          verifyEmailRoute, (route) => false);
                    }
                    // Flushbar(
                    //   backgroundColor: Colors.white,
                    //   messageColor: Color.fromARGB(255, 32, 218, 15),
                    //   message: "You are login",
                    //   duration: Duration(seconds: 2),
                    // ).show(context);
                  } on UserNotFoundAuthException {
                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Colors.red,
                      message: "User not found",
                      duration: Duration(seconds: 2),
                    ).show(context);
                  } on WrongPasswordAuthException {
                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Colors.red,
                      message: "Wrong Password",
                      duration: Duration(seconds: 2),
                    ).show(context);
                  } on GenericAuthException {
                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Colors.red,
                      message: "Some error occured",
                      duration: Duration(seconds: 2),
                    ).show(context);
                  }
                },
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(registerRoute);
              },
              child: const Text("Not regiseter yet ? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> showErroDialog(
//   BuildContext context,
//   String text,
// ){
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: const Text("Error"),
//         content: Text(text),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text("ok"),
//           ),
//         ],
//       );
//     },
//   );
// }
