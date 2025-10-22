import 'package:test/test.dart';
import '../lib/data/quiz_file_provider.dart';
import '../lib/domain/quiz.dart';

void main() {
  test('Read quiz from JSON file', () {
    var repo = QuizRepository('assets/quiz_data.json');
    Quiz quiz = repo.readQuiz();

    expect(quiz.questions.length, greaterThan(0));
    expect(quiz.questions[0].title, isNotEmpty);
  });
}
