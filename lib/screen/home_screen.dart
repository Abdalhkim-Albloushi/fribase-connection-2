import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/screen/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const homeRoute = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.loginRoute, (route) => false);
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign In..'),
          onPressed: () async {},
        ),
      ),
    );
  }
}
