import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp1/view/signin.dart';
import '../widgets/widgets.dart';
import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
Widget build(BuildContext context){
    return Scaffold( 
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      centerTitle: true,
      title: appBar(context),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      ),
      body: Form(
        child: Container(
          decoration: const BoxDecoration(
          image: DecorationImage(
          image: NetworkImage(
            'https://cdn.discordapp.com/attachments/547558541624344597/1082540156810166272/WvTM5z-aLdYxhNiIHdwQ7BRw-SmmxBdxGsLtDn8BI4o.png'
          ),
          fit:BoxFit.cover,
        ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
          const Spacer(),
          TextFormField(
            controller: _nameTextController,
           decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Name",
            ),
          ),
          SizedBox(height: 12,),
          TextFormField(
            controller: _emailTextController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Email",
            ),
          ),
          SizedBox(height: 12,),
            TextFormField(
            controller: _passwordTextController,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Password"
            ),
          ),
          SizedBox(height: 14,),
          SignInSignOutButton(context, false, () {
            FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text, 
            password: _passwordTextController.text).then((value){
            print('created new account');
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            });
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? ", style: TextStyle(fontSize: 15.5),),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => SignIn()
                  ));
                },
                child: Text("Sign In", style: TextStyle(fontSize: 15.5,
                decoration: TextDecoration.underline),),
              )
            ],
          ),
          SizedBox(height: 30,),
          ],),
        ),
      ),
    );
  }
}
