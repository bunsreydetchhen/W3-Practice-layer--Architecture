import 'dart:convert';
import 'dart:io';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz() {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('Quiz file not found: $filePath');
    }

    final content = file.readAsStringSync();
    final data = jsonDecode(content);
    return Quiz.fromJson(data);
  }

  void writeQuiz(Quiz quiz) {
    final file = File(filePath);
    final jsonData = jsonEncode(quiz.toJson());
    file.writeAsStringSync(jsonData);
  }
}
