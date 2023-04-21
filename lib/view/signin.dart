import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "home.dart";
import 'signup.dart';
import "../widgets/widgets.dart";
import "../widgets/widget.dart";

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(""),
        elevation: 0.0,
      ),
      body: Form(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              AppLogo(),
              TextFormField(
                controller: _emailTextController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Password"),
              ),
              SizedBox(
                height: 14,
              ),
              SignInSignOutButton(context, true, () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Home(userid: value.user?.uid ?? '')));
                });
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 15.5),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 15.5, decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
