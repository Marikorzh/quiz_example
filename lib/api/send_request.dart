import "dart:convert";
import "package:http/http.dart" as http;
import "model_quiz.dart";

Future<QuizResponse> fetchQuizRequest(List<String>? selected) async {

  String? number = selected?[0];
  String? category = filterCategory(selected![1]);
  String? difficulty = selected[2]=="Any" ? "&difficulty=${selected[2].toLowerCase()}" : "";

  var url = Uri.parse('https://opentdb.com/api.php?amount=$number$category$difficulty&type=multiple');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final quizData = QuizResponse.fromJson(json.decode(response.body));
    return quizData;
  } else {
    throw Exception('Failed to load quiz data');
  }
}

String filterCategory(String book){
  switch (book){
    case 'Books':
      return "&category=10";
    case "Films":
      return "&category=11";
    case "Music":
      return "&category=12";
    case "Video Games":
      return "&category=15";
    default:
      return "";
  }
}
