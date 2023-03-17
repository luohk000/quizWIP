//TODO: keep track of score per quiz, show results page
//TODO: progress bar TOTAL GPA (aggregate all the questions of all quizzes and count # of right/wrong)

import 'package:flutter/material.dart';
import 'package:quizapp1/view/quiz1.dart';
import 'package:quizapp1/view/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore db = FirebaseFirestore.instance; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Quizzes')),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: (){
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn())
            );
          },
        )
      ),
      body: Container(
      child: ListView(
      children: <Widget>[
         Card(
          child: ListTile(
            title: Text('Quiz 1', style: TextStyle(fontSize: 30),),
            subtitle:
                Text('Unit 1: Primitive types'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
            onTap: () {
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => Quiz1(quizID: "Quiz1"))
            );
            },
          )
         ),
          Card(
          child: ListTile(
            title: Text('Quiz 2', style: TextStyle(fontSize: 30),),
            subtitle:
                Text('Unit 2: Boolean'),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
            onTap: () {
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => Quiz1(quizID: "Quiz2"))
            );
            },
          ),
         ),
      ],
       ),
      ),
    );
  }
}