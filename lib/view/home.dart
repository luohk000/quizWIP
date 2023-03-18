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

  Widget buildMyCard(BuildContext context, String quizID) {
    return Card(
          child: ListTile(
            title: Text(quizID, style: TextStyle(fontSize: 30),),
            // subtitle:
            //     Text(subtitle),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => Quiz1(quizID: quizID))
            );
            },
          )
         );
  }


  @override
  Widget build(BuildContext context) {
    List<String> allQuizIds = ["Quiz1", "Quiz2", "Quiz3"];
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: const Text('Dashboard')),
      // put this logout button somewhere else
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //   height: 50,
      //   margin: const EdgeInsets.all(10),
      //   child: ElevatedButton(
      //     child: Text("Logout"),
      //     onPressed: (){
      //       Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => SignIn())
      //       );
      //     },
      //   )
      // ),
      body: Container(
      child: ListView(
      children: <Widget>[
        ...allQuizIds.map((quiz) {
          return buildMyCard(context, quiz);
        //   child: ListTile(
        //     title: Text('Quiz', style: TextStyle(fontSize: 30),),
        //     // subtitle:
        //     //     Text('Unit 1: Primitive types'),
        //     trailing: Icon(Icons.more_vert),
        //     // isThreeLine: true,
        //     onTap: () {
        //       Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => Quiz1(quizID: quiz))
        //     );
        //     },
        //   )
        //  );
        }),
        //  Card(
        //   child: ListTile(
        //     title: Text('Quiz 1', style: TextStyle(fontSize: 30),),
        //     subtitle:
        //         Text('Unit 1: Primitive types'),
        //     trailing: Icon(Icons.more_vert),
        //     isThreeLine: true,
        //     onTap: () {
        //       Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => Quiz1(quizID: "Quiz1"))
        //     );
        //     },
        //   )
        //  ),
        //   Card(
        //   child: ListTile(
        //     title: Text('Quiz 2', style: TextStyle(fontSize: 30),),
        //     subtitle:
        //         Text('Unit 2: Boolean'),
        //     trailing: Icon(Icons.more_vert),
        //     isThreeLine: true,
        //     onTap: () {
        //       Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => Quiz1(quizID: "Quiz2"))
        //     );
        //     },
        //   ),
        //  ),
      ],
       ),
      ),
    );
  }
}