import 'package:flutter/material.dart';
import 'package:privatenotes/constant/routes.dart';
import 'package:privatenotes/screens/emailverify_screen.dart';
import 'package:privatenotes/screens/homepage_screen.dart';
import 'package:privatenotes/screens/login_screen.dart';
import 'package:privatenotes/screens/notes_screen.dart';
import 'package:privatenotes/screens/register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomepageScreen(),
      routes: {
        loginRoute: (context) => const LoginScreen(),
        registerRoute: (context) => const RegisterScreen(),
        noteRoute: (context) => const NotesScreen(),
        verifyEmailRoute: (context) => const EmailVerifyScreen(),
      },
    );
  }
}
