import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;
  Scoreboard scoreboard = Scoreboard();

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('Welcome to the Multi-Player Quiz');

    while (true) {
      stdout.write('Enter player name: ');
      String? playerName = stdin.readLineSync();

      if (playerName == null || playerName.isEmpty) {
        print('Exiting game');
        break;
      }

      Player player = Player(playerName);
      quiz.reset();

      print('Starting quiz for ${player.name}');
      for (var question in quiz.questions) {
        print('Question: ${question.title}');
        print('Choices: ${question.choices}');
        print('(Worth ${question.points} point(s))');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        if (userInput != null && userInput.isNotEmpty) {
          var answer = Answer(questionId: question.id, answerChoice: userInput);
          quiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping.');
        }
      }

      int earned = quiz.getEarnedPoints();
      int possible = quiz.getPossiblePoints();
      int scorePercent = quiz.getScoreInPercentage();

      player.lastPoints = earned;
      player.lastScore = scorePercent;

      var result = QuizFinished(
        player: player,
        earnedPoints: earned,
        possiblePoints: possible,
      );
      scoreboard.recordResult(result);

      print(' ${player.name} Finished');
      print('Score: $earned / $possible points ($scorePercent%)');

      scoreboard.showResults();
    }
  }
}
