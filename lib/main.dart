import 'package:flutter/material.dart';
import 'package:privatenotes/screens/homepage_screen.dart';
import 'package:privatenotes/screens/login_screen.dart';
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
      home: HomepageScreen(),
      routes: {
        '/login/': (context) => LoginScreen(),
        '/register/': (context) => RegisterScreen(),
      },
    );
  }
}
