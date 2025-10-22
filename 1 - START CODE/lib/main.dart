import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_file_provider.dart';

void main() {
  var repo = QuizRepository('assets/quiz_data.json');
  Quiz quiz = repo.readQuiz();

  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();
}
