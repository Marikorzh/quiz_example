import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/pages/quiz_results.dart';
import 'package:untitled3/pages/start_page.dart';
import '../api/model_quiz.dart';
import '../api/send_request.dart';

class QuizPage extends StatefulWidget {
  final List<String> res;
  QuizPage({required this.res});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool isLoading = true;
  QuizResponse? quizData;
  List<String>? answers;
  List<String> userAnswers = [];
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  Future<void> _loadQuizData() async {
    try {
      quizData = await fetchQuizRequest(widget.res);
    } catch (e) {
      print('Error loading quiz data: $e');
    } finally {
      _prepareAnswers();
      setState(() {
        isLoading = false;
      });
    }
  }

  void _prepareAnswers() {
    if (quizData != null) {
      answers = List.from(quizData!.results[currentQuestionIndex].incorrectAnswers)
        ..add(quizData!.results[currentQuestionIndex].correctAnswer)
        ..shuffle();
      selectedAnswerIndex = null;
    }
  }

  void _score(){
    for(int i = 0; i < userAnswers.length; i++){
      if(userAnswers[i] == quizData?.results[i].correctAnswer) score++;
    }
  }

  void _nextQuestion() {
    userAnswers.add(answers![selectedAnswerIndex!]);
    if (currentQuestionIndex < quizData!.results.length - 1) {
      setState(() {
        currentQuestionIndex++;
        _prepareAnswers();
      });
    } else {
      _score();
      _showResults();
    }
  }

  void _showResults() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizResults(userAnswers: userAnswers, quizData: quizData!, score: score,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : quizData != null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                quizData!.results[currentQuestionIndex].question,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ..._buildAnswerOptions(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _nextQuestion,
                child: Text(currentQuestionIndex == quizData!.results.length - 1
                    ? "Show Results"
                    : "Next"),
              ),
            ],
          ),
        ),
      )
          : Center(child: Text('Failed to load quiz data')),
    );
  }

  List<Widget> _buildAnswerOptions() {
    return answers!.asMap().entries.map((entry) {
      int idx = entry.key;
      String answerText = entry.value;

      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: selectedAnswerIndex == idx ? Colors.green.shade200 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              selectedAnswerIndex = idx;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              answerText,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }).toList();
  }
}
