import 'package:flutter/material.dart';
import 'package:untitled3/api/model_quiz.dart';

class QuizResults extends StatelessWidget {
  final List<String>? userAnswers;
  final QuizResponse? quizData;
  final int? score;

  const QuizResults({super.key, required this.userAnswers, required this.quizData, required this.score});



  @override
  Widget build(BuildContext context) {
    if (quizData == null || userAnswers == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Results")),
        body: const Center(child: Text("No quiz data or user answers available")),
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: Text("Results: ${score}/${quizData!.results.length}"),
          automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {},
          child: const Center(
            child: Text('Hello'),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: quizData!.results.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question: ${quizData!.results[index].question}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text("Correct Answer: ${quizData!.results[index].correctAnswer}"),
                Text("Your Answer: ${userAnswers![index]}"),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
