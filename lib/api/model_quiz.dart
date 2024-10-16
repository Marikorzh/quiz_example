class QuizResponse {
  final int responseCode;
  final List<QuizQuestion> results;

  QuizResponse({
    required this.responseCode,
    required this.results,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      responseCode: json['response_code'],
      results: (json['results'] as List)
          .map((item) => QuizQuestion.fromJson(item))
          .toList(),
    );
  }
}

class QuizQuestion {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  QuizQuestion({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }
}
