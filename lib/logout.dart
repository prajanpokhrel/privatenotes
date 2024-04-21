import 'package:flutter/material.dart';

enum MenuAction { logout }

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Log out'),
        content: const Text("Are you sure you want to logout"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Logout"),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
