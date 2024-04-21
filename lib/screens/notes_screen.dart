import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:privatenotes/logout.dart';

enum MenuAction { logout }

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leadingWidth: 200,
        leading: Title(
          color: Colors.black,
          child: const Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: Text(
              "Notes App",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);

                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("/login/", (_) => false);
                    Flushbar(
                      backgroundColor: Colors.white,
                      messageColor: Colors.red,
                      message: "You are logout",
                      duration: const Duration(seconds: 2),
                    ).show(context);
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Log out"),
                )
              ];
            },
          ),
        ],
      ),
      body: const Column(
        children: [Text('Hello from notes')],
      ),
    );
  }
}
