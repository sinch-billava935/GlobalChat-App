import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:globalchat/controllers/signup_controller.dart';
import 'package:globalchat/screens/dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var userForm = GlobalKey<FormState>(); //

  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),

      body: Expanded(
        //to overcome the layout error
        child: SingleChildScrollView(
          //to enable scrolling
          child: Form(
            key: userForm,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,

                    child: Image.asset("assets/images/logo.png"),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                    },
                    decoration: InputDecoration(label: Text("Email")),
                  ),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    controller: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(label: Text("Password")),
                  ),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      }
                    },
                    decoration: InputDecoration(label: Text("Name")),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: country,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Country is required";
                      }
                    },
                    decoration: InputDecoration(label: Text("Country")),
                  ),
                  SizedBox(height: 23),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(0, 50),
                            foregroundColor: Colors.white,
                            backgroundColor: const Color.fromARGB(
                              255,
                              52,
                              126,
                              160,
                            ),
                          ),
                          onPressed: () {
                            if (userForm.currentState!.validate()) {
                              //create account
                              isLoading = true;
                              setState(() {});
                              SignupController.createAccount(
                                email: email.text,
                                password: password.text,
                                country: country.text,
                                name: name.text,
                                context: context,
                              );
                              isLoading = false;
                              setState(() {});
                            }
                          },
                          child:
                              isLoading
                                  ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                  : Text('Create Account'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
