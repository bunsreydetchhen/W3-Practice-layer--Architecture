
import 'dart:convert';
import 'dart:io';

import 'package:my_first_project/domain/quiz.dart';

class Quizrepository {
  final String filePath;

  Quizrepository(this.filePath);
  Quiz readQuiz(){
    final file = File(filePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content);

    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(title: q['title'],
      choices: List<String>.from(q['choices']),
      goodChoice: ' ',
      points: 0,
      );
    }).toList();
    return Quiz(questions: questions);
  }
}