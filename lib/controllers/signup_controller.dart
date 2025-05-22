import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:globalchat/screens/splash_screen.dart';

class SignupController {
  //function used for firebase authentication which takes time for the job to be done, therefore await and async
  static Future<void> createAccount({
    required String email,
    required String password,
    required String name,
    required String country,
    required BuildContext context,
  }) async {
    //
    //to handle error use try catch block
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userId =
          FirebaseAuth
              .instance
              .currentUser!
              .uid; //it access the unique id given by the firebase after signIn
      var db = FirebaseFirestore.instance;

      Map<String, dynamic> data = {
        "name": name,
        "country": country,
        "email": email,
        "id": userId.toString(),
      };
      try {
        await db.collection("users").doc(userId.toString()).set(data);
      } catch (e) {
        print(e);
      }

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
