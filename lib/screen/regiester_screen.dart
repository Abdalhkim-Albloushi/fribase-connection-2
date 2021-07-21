import 'package:firebase_auth/firebase_auth.dart';
import '../screen/alert.dart';
import '../screen/home_screen.dart';
import '../screen/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const registerRoute = "/register";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? username, password, email;
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

  GlobalKey<FormState> formState = GlobalKey();
  siginUp() async {
    FormState? formdata = formState.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showDownloding(context);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!,
          password: password!,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        // if (e.code == 'weak-password') {
        //   showMyDialog();
        //   print('The password  weak.');
        // } else if (e.code == ) {
        //   showMyDialog();
        //   print('The account already exists .');
        // }
        switch (e.code) {
          case 'weak-password':
            {
              Navigator.of(context).pop();
              return showMyDialog('password is weack');
            }

          case 'email-already-in-use':
            {
              Navigator.of(context).pop();
              return showMyDialog('you have acount');
            }
          case 'invalid-email':
            {
              Navigator.of(context).pop();
              return showMyDialog('invalid email');
            }
          default:
            return null;
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('ok');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
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
                onSaved: (value) => username = value!,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  hintText: 'userName',
                ),
              ),
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
                  dynamic siginup = await siginUp();
                  if (siginup != null) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.homeRoute, (route) => false);
                  }
                },
                child: Text('SeginUp'),
              ),
              OutlinedButton(
                onPressed: () async{
                  var user = await siginUp();
                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (cxt) => LoginScreen(),
                    ));
                  }
                },
                child: Text('Sigin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
