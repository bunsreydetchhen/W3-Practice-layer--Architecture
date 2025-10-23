import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');
    while (true) {
      stdout.write('Your name: ');
      String? nameInput = stdin.readLineSync();
      if (nameInput == null || nameInput == '' || nameInput.isEmpty) {
        print('--- Quiz Finished ---');
        break;
      }
      Player newPlayer = Player(nameInput);
      quiz.players.add(newPlayer);
      for (var question in quiz.questions) {
        print('Question: ${question.title} - ( ${question.points} points )');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        // Check for null input
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          quiz.addAnswer(quiz.players.last, answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      int score = quiz.getScoreInPercentage(quiz.players.last);
      print('Your score: $score % correct');

      int point = quiz.getScoreInPoint(quiz.players.last);
      print('Your score in points: $point');

      if (quiz.players.length > 1) {
        for (var player in quiz.players) {
          print(
            "Player: ${player.name} \t Score:${quiz.getScoreInPoint(player)}",
          );
        }
      }
    }
  }
}
