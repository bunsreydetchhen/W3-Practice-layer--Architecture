import 'package:test/test.dart';
import '../lib/domain/quiz.dart';

void main() {
  test('Quiz scoring with points per question', () {
    Question q1 = Question(
      title: "Capital of France?",
      choices: ["Paris", "London", "Rome"],
      goodChoice: "Paris",
      points: 10,
    );
    Question q2 = Question(
      title: "2 + 2 = ?",
      choices: ["2", "4", "5"],
      goodChoice: "4",
      points: 50,
    );

    Quiz quiz = Quiz(questions: [q1, q2]);
    quiz.addAnswer(Answer(questionId: q1.id, answerChoice: "Paris"));
    quiz.addAnswer(Answer(questionId: q2.id, answerChoice: "4"));

    expect(quiz.getEarnedPoints(), equals(60));
    expect(quiz.getPossiblePoints(), equals(60));
    expect(quiz.getScoreInPercentage(), equals(100));
  });

  test('Partial score calculation', () {
    Question q1 = Question(
      title: "Capital of France?",
      choices: ["Paris", "London", "Rome"],
      goodChoice: "Paris",
      points: 10,
    );
    Question q2 = Question(
      title: "2 + 2 = ?",
      choices: ["2", "4", "5"],
      goodChoice: "4",
      points: 50,
    );

    Quiz quiz = Quiz(questions: [q1, q2]);
    quiz.addAnswer(Answer(questionId: q1.id, answerChoice: "Rome"));
    quiz.addAnswer(Answer(questionId: q2.id, answerChoice: "4"));

    expect(quiz.getEarnedPoints(), equals(50));
    expect(quiz.getScoreInPercentage(), equals(83));
  });

  test('Multiple players tracked on scoreboard', () {
    Question q1 = Question(
      title: "Capital of France?",
      choices: ["Paris", "London", "Rome"],
      goodChoice: "Paris",
      points: 10,
    );
    Question q2 = Question(
      title: "2 + 2 = ?",
      choices: ["2", "4", "5"],
      goodChoice: "4",
      points: 50,
    );

    Quiz quiz = Quiz(questions: [q1, q2]);
    Scoreboard board = Scoreboard();

    Player alice = Player("Alice");
    quiz.addAnswer(Answer(questionId: q1.id, answerChoice: "Paris"));
    quiz.addAnswer(Answer(questionId: q2.id, answerChoice: "4"));
    board.recordResult(QuizFinished(
      player: alice,
      earnedPoints: quiz.getEarnedPoints(),
      possiblePoints: quiz.getPossiblePoints(),
    ));

    quiz.reset();

    Player bob = Player("Bob");
    quiz.addAnswer(Answer(questionId: q1.id, answerChoice: "London"));
    quiz.addAnswer(Answer(questionId: q2.id, answerChoice: "4"));
    board.recordResult(QuizFinished(
      player: bob,
      earnedPoints: quiz.getEarnedPoints(),
      possiblePoints: quiz.getPossiblePoints(),
    ));

    expect(board.allResults.length, equals(2));
    expect(board.allResults.any((r) => r.player.name == "Alice"), isTrue);
    expect(board.allResults.any((r) => r.player.name == "Bob"), isTrue);
  });
}
