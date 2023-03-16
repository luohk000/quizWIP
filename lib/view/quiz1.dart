import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quizapp1/view/results.dart';

class Quiz1 extends StatefulWidget {
  const Quiz1({super.key});
  

  @override
  State<Quiz1> createState() => _Quiz1State();
}

class _Quiz1State extends State<Quiz1> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late List<QNA> qnalist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz 1')),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('Quiz1').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot question) {
              Map<String, dynamic> data = question.data()! as Map<String, dynamic>;
              QNA qna = QNA(data['Prompt'], data['Answer'], data[data['Answer']]);
              qnalist.add(qna);
              return Column(
                children:[ 
                  ListTile(
                  title: Text(data['Prompt'], style: TextStyle(fontSize: 20),),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('A', style: TextStyle(fontSize: 30),),
                      subtitle:
                          Text(data['A']),
                      onTap: () {
                        qna.choice = 'A';
                        qna.choiceDesc = data['A'];
                      },
                    )
                  ),
                  Card(
                    child: ListTile(
                      title: Text('B', style: TextStyle(fontSize: 30),),
                      subtitle:
                          Text(data['B']),
                      onTap: () {
                        qna.choice = 'B';
                        qna.choiceDesc = data['B'];
                      },
                    )
                  ),
                  Card(
                    child: ListTile(
                      title: Text('C', style: TextStyle(fontSize: 30),),
                      subtitle:
                          Text(data['C']),
                      onTap: () {
                        qna.choice = 'C';
                        qna.choiceDesc = data['C'];
                      },
                    )
                  ),
                  Card(
                    child: ListTile(
                      title: Text('D', style: TextStyle(fontSize: 30),),
                      subtitle:
                          Text(data['D']),
                      onTap: () {
                        qna.choice = 'D';
                        qna.choiceDesc = data['D'];
                      },
                    )
                  ),
                  Card(
                    child: ListTile(
                      title: Text('E', style: TextStyle(fontSize: 30),),
                      subtitle:
                          Text(data['E']),
                      onTap: () {
                        qna.choice = 'E';
                        qna.choiceDesc = data['E'];
                      },
                    )
                  ),
                ]
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for(int i = 0; i < qnalist.length; i++){
            print(i);
            print(qnalist[i].prompt);
            print(qnalist[i].answer);
            print(qnalist[i].choice);
            print(qnalist[i].answerDesc);
            print(qnalist[i].choiceDesc);
          }

          Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => ResultsPage()
                  ));

        },
        tooltip: 'Submit',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class QNA{
   String prompt = "";
   String answer = "";
   String answerDesc = "";
   String choiceDesc = "";
   String choice = "";
  QNA(prompt, answer, answerDesc) {
    this.prompt = prompt;
    this.answer = answer;
    this.answerDesc = answerDesc;
  }
}
