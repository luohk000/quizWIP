import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quizapp1/view/results.dart';

class Quiz1 extends StatefulWidget {
  Quiz1({super.key, required this.quizID});
  String quizID; 
  bool showAnswers = false;

  @override
  State<Quiz1> createState() => _Quiz1State();
}

class _Quiz1State extends State<Quiz1> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late Map<String, String> choices = {};

  Color? getColor(String prompt, String choiceKey, String answerChoice) { 
    if (!widget.showAnswers) {
      if (choices[prompt] == choiceKey) return Colors.blue[400];
      else return null;
    }
    else {
      if (choiceKey == answerChoice) return Colors.green[400];
      else if (choiceKey == choices[prompt] && choices[prompt] != answerChoice) return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz :3')),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection(widget.quizID).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot question) {
              Map<String, dynamic> data = question.data()! as Map<String, dynamic>;
              List<String> choiceKeys = ["A", "B", "C", "D", "E"];
              return Column(
                children:[ 
                  Text(choices[data['Prompt']]?? "no answer"),
                  ListTile(
                  title: Text(data['Prompt'], style: TextStyle(fontSize: 20),),
                  ),
                  ...choiceKeys.map((choiceKey) {
                    return Card(
                    color: getColor(data['Prompt'], choiceKey, data['Answer']),
                    child: ListTile(
                      title: Text(choiceKey, style: TextStyle(fontSize: 30),),
                      subtitle:
                          Text(data[choiceKey]),
                      onTap: !widget.showAnswers ? () {
                        setState(() { choices[data['Prompt']] = choiceKey; });
                      } : null,
                    )
                  );
                  })
                ]
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // for(int i = 0; i < qnalist.length; i++){
          //   print(i);
          //   print(qnalist[i].prompt);
          //   print(qnalist[i].answer);
          //   print(qnalist[i].choice);
          //   print(qnalist[i].answerDesc);
          //   print(qnalist[i].choiceDesc);
          // }
          setState( () { widget.showAnswers = true;});

          

        },
        tooltip: 'Submit',
        child: const Icon(Icons.add),
      ),
    );
  }
}


