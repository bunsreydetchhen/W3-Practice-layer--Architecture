 
import 'package:my_first_project/domain/QuizRepository.dart';

//import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {
  var repo = QuizRepository('lib/data/quiz.json');
  var quiz = repo.readQuiz();
  QuizConsole console = QuizConsole(quiz: quiz);

  console.startQuiz();
}
