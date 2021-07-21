import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screen/test.dart';
import '../screen/regiester_screen.dart';
import '../screen/login_screen.dart';

import '../screen/home_screen.dart';
import 'package:flutter/material.dart';

bool isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogin = false;
  } else {
    isLogin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.red,
      ),
     
       initialRoute: isLogin == false ? LoginScreen.loginRoute : HomeScreen.homeRoute,
      routes: {
        HomeScreen.homeRoute: (cxt) => HomeScreen(),
        LoginScreen.loginRoute: (cxt) => LoginScreen(),
        RegisterScreen.registerRoute: (cxt) => RegisterScreen(),
      },
    );
  }
}
