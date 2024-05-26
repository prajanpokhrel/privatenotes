import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        title: const Text("login "),
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
                    final UserCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);
                    Navigator.of(context).pushNamed('/notes/');

                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Color.fromARGB(255, 32, 218, 15),
                      message: "You are login",
                      duration: Duration(seconds: 2),
                    ).show(context);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'invalid-credential') {
                      Flushbar(
                        backgroundColor: Colors.white,
                        messageColor: Colors.red,
                        message: "Invalid Credentials",
                        duration: Duration(seconds: 2),
                      ).show(context);
                    } else {
                      Flushbar(
                        backgroundColor: Colors.white,
                        messageColor: Colors.red,
                        message: "Some error occured",
                        duration: Duration(seconds: 2),
                      ).show(context);
                    }
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
                Navigator.of(context).pushNamed('/register/');
              },
              child: const Text("Not regiseter yet ? Register here"),
            ),
          ],
        ),
      ),
    );
  }
}
