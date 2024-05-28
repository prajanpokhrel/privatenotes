import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:privatenotes/constant/routes.dart';
import 'package:privatenotes/services/auth/auth_exception.dart';
import 'package:privatenotes/services/auth/auth_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
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
            SizedBox(
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
                        .createUser(email: email, password: password);
                    final user = AuthServices.firebase().currentUser;
                    await user?.sendEmailVerification();
                    Navigator.of(context).pushNamed(verifyEmailRoute);

                    // Flushbar(
                    //   backgroundColor: Colors.white,
                    //   messageColor: Color.fromARGB(255, 54, 235, 9),
                    //   message: "Your account is created",
                    //   duration: Duration(seconds: 2),
                    // ).show(context);
                  } on EmailAlreadyInUseAuthException {
                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Colors.red,
                      message: "Email already in use try another",
                      duration: Duration(seconds: 2),
                    ).show(context);
                  } on WeakPasswordAuthException {
                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Colors.red,
                      message: "Email already in use try another",
                      duration: Duration(seconds: 2),
                    ).show(context);
                  } on InvalidEmailAuthException {
                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Colors.red,
                      message: "Invalid email please use @",
                      duration: Duration(seconds: 2),
                    ).show(context);
                  } on GenericAuthException {
                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Colors.red,
                      message: "Something went wrong",
                      duration: Duration(seconds: 2),
                    ).show(context);
                  }
                },
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(loginRoute);
              },
              child: Text("Already Register ? login here"),
            ),
          ],
        ),
      ),
    );
  }
}
