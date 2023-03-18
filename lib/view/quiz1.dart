import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quizapp1/view/results.dart';

class Quiz1 extends StatefulWidget {
  Quiz1(
      {super.key,
      required this.quizID,
      required this.userid,
      required this.setHomeState});
  String quizID;
  bool showAnswers = false;
  String userid;
  Function setHomeState;

  @override
  State<Quiz1> createState() => _Quiz1State();
}

class _Quiz1State extends State<Quiz1> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late Map<String, String> choices =
      {}; // key : actual question/prompt, value: user submitted answer

  Color? getColor(String questionid, String choiceKey, String answerChoice) {
    if (!widget.showAnswers) {
      if (choices[questionid] == choiceKey)
        return Colors.blue[400];
      else
        return null;
    } else {
      if (choiceKey == answerChoice)
        return Colors.green[400];
      else if (choiceKey == choices[questionid] &&
          choices[questionid] != answerChoice) return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: (!widget.showAnswers) ? Text('Quiz') : Text('Results')),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection(widget.quizID).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading...");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot question) {
              print(question.id);
              Map<String, dynamic> data =
                  question.data()! as Map<String, dynamic>;
              List<String> choiceKeys = ["A", "B", "C", "D", "E"];
              return Column(children: [
                // Text(choices[data['Prompt']]?? "this shouldn't show"),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      data['Prompt'],
                      style: TextStyle(fontSize: 20),
                    )),
                ...choiceKeys.map((choiceKey) {
                  return Card(
                      color: getColor(question.id, choiceKey, data['Answer']),
                      child: ListTile(
                        title: Text(
                          choiceKey,
                          style: TextStyle(fontSize: 30),
                        ),
                        subtitle: !widget.showAnswers ||
                                choiceKey != data['Answer']
                            ? Text(data[choiceKey])
                            : Text('${data[choiceKey]}\n ${data['Explain']}'),
                        onTap: !widget.showAnswers
                            ? () {
                                setState(() {
                                  choices[question.id] = choiceKey;
                                });
                              }
                            : null,
                      ));
                })
              ]);
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          db.collection(widget.quizID).get().then((querySnapshot) {
            int correct = 0;
            int totalquestions = querySnapshot.docs.length;
            for (var docSnapshot in querySnapshot.docs) {
              //question id : usser choicec __ CHOCIES
              // docSnapshot.id --> question id
              // docsnapshot.daataanswer --> correct answer
              // assuming USER QNSWERS ALL QUESTIONS
              if (choices[docSnapshot.id] == docSnapshot.data()["Answer"])
                correct++;
            }
            double scoreXD = correct / querySnapshot.docs.length;

            setState(() {
              var us3r = <String, dynamic>{
                ...choices,
                "score": scoreXD,
                "numCorrect": correct,
                "totalQuestion": totalquestions,
              };

              widget.showAnswers = true;
              db
                  .collection(widget.userid)
                  .doc(widget.quizID)
                  .set(us3r)
                  .then((temp) {
                widget.setHomeState();
              });
            });
          });
        },
        tooltip: 'Submit',
        child: const Icon(Icons.add),
      ),
    );
  }
}
