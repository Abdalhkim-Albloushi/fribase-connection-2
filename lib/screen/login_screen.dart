import 'package:firebase_auth/firebase_auth.dart';
import '../screen/alert.dart';
import '../screen/home_screen.dart';

import '../screen/regiester_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const loginRoute = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? username, password, email;
  GlobalKey<FormState> formState = GlobalKey();

  Future<void> showMyDialog(String des) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            des,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, color: Colors.red),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Dane',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  sigin() async {
    FormState? formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        showDownloding(context);
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email!,
          password: password!,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'user-not-found':
            {
              Navigator.of(context).pop();
              showMyDialog('user not fond');

              break;
            }

          case 'wrong-password':
            {
              Navigator.of(context).pop();
              showMyDialog('Wrong password');

              break;
            }
          case 'invalid-email':
            {
              Navigator.of(context).pop();
              showMyDialog('user not fond');

              break;
            }
          default:
            Navigator.of(context).pop();
            showMyDialog('please inter your email');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Center(
        child: Form(
          key: formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) =>
                    value!.length > 50 ? 'Can not be greter than 50' : null,
                onSaved: (value) => email = value!,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  hintText: 'Email',
                ),
              ),
              TextFormField(
                validator: (value) =>
                    value!.length < 4 ? 'Can not be less than 4' : null,
                onSaved: (value) => password = value!,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  hintText: 'password',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  dynamic user = await sigin();
                 if (user != null) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.homeRoute, (route) => false);
                  }
                },
                child: Text('Login'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (cxt) => RegisterScreen(),
                  ));
                },
                child: Text('register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
