//TODO: keep track of score per quiz, show results page
//TODO: progress bar TOTAL GPA (aggregate all the questions of all quizzes and count # of right/wrong)

import 'package:flutter/material.dart';
import 'package:quizapp1/view/quiz1.dart';
import 'package:quizapp1/view/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatefulWidget {
   Home({super.key, required this.userid});
  String userid;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore db = FirebaseFirestore.instance; 
  List<double> allScores =[];

  

  Widget buildMyCard(BuildContext context, String quizID) {
    return Card(
          child: ListTile(
            title: Text(quizID, style: TextStyle(fontSize: 30),),
            // subtitle:
            //     Text(score.toString()),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => Quiz1(quizID: quizID, userid: widget.userid))
            );
            },
          )
         );
  }

  void getScores() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection(widget.userid).get().then( (querySnapshot ) {
      print("hi im in then");
      print(allScores);
      print(querySnapshot.docs.length);
      List<double> temp = [];
      for (var docSnapshot in querySnapshot.docs) {
        if (docSnapshot.data()["score"] == null) continue;
        temp.add(docSnapshot.data()["score"]); 
      }
      setState( () {
        allScores = temp;
        print(allScores);
      } );
    });
    print(allScores);
  }

  double getAvg() {
    double sum = 0;
    for (double score in allScores) sum += score;
    return sum / allScores.length;
  }

  @override
  void initState() {
    super.initState();
    getScores();
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
        Padding(padding: EdgeInsets.all(35), 
        child: CircularPercentIndicator(
          radius: 150, percent: allScores.isEmpty ? 0.0 : getAvg(),
           center: allScores.isEmpty ? const Text("LOADING PROGRESS!") : Text((getAvg()*100).toString()))),
        ...allQuizIds.map((quiz) {
          return buildMyCard(context, quiz);
        }),
      ],
       ),
      ),
    );
  }
}