import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard_screen.dart';
import 'package:globalchat/screens/splash_screen.dart';

class LoginController {
  //function used for firebase authentication which takes time for the job to be done, therefore await and async
  static Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    //
    //to handle error use try catch block
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        ),
        (route) {
          return false;
        },
      );
      print("account created succesfully");
    } catch (e) {
      SnackBar messageSnackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);

      print(e);
    }
  }
}
