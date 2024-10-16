import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  List<String> answers;
  AnswerCard({required this.answers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: answers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(answers[index]),
            );
          },
        ),
    );
  }
}
