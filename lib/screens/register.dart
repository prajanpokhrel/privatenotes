import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                enableSuggestions: false,
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "password"),
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
                    final UserCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                    Navigator.of(context).pushNamed('/login/');

                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Color.fromARGB(255, 54, 235, 9),
                      message: "Your account is created",
                      duration: Duration(seconds: 2),
                    ).show(context);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      Flushbar(
                        backgroundColor: Colors.white,
                        messageColor: Colors.red,
                        message: "Email already in use try another",
                        duration: Duration(seconds: 2),
                      ).show(context);
                    } else if (e.code == 'weak-password') {
                      Flushbar(
                        backgroundColor: Colors.white,
                        messageColor: Colors.red,
                        message: "Weak password please keep strong password",
                        duration: Duration(seconds: 2),
                      ).show(context);
                    } else if (e.code == 'invalid-email') {
                      Flushbar(
                        backgroundColor: Colors.white,
                        messageColor: Colors.red,
                        message: "Invalid email please use @",
                        duration: Duration(seconds: 2),
                      ).show(context);
                    }
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
                Navigator.of(context).pushNamed('/login/');
              },
              child: Text("Already Register ? login here"),
            ),
          ],
        ),
      ),
    );
  }
}
