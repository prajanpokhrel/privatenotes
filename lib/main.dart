import 'package:flutter/material.dart';
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
        '/login/': (context) => const LoginScreen(),
        '/register/': (context) => const RegisterScreen(),
        '/notes/': (context) => const NotesScreen(),
      },
    );
  }
}
