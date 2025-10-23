import 'package:uuid/uuid.dart';

class Question {
  var id = Uuid();
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;
  Uuid get questionId{
    return id;
  }

  Question({
    required this.title,
    required this.choices,
    required this.goodChoice,
    required this.points,
  });
}

class Answer {
  final Question question;
  final String answerChoice;
  String get id{
    return id;
  }
  Answer({required this.question, required this.answerChoice});

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Player {
  final String? name;
  int scoreInPoint = 0;
  int scoreInPercentage = 0;
  List<Answer> answers = [];

  Player(this.name);
}

class Quiz {
  List<Question> questions;
  List<Player> players = [];
  String get id{
    return id;
  }

  Quiz({required this.questions});

  void addAnswer(Player player, Answer answer) {
    player.answers.add(answer);
  }

  int getScoreInPercentage(Player player) {
    player.scoreInPercentage = 0;
    for (Answer answer in player.answers) {
      if (answer.isGood()) {
        player.scoreInPercentage ++;
      }
    }
    return ((player.scoreInPercentage / questions.length) * 100).toInt();
  }

  int getScoreInPoint(Player player) {
    player.scoreInPoint = 0;
    for (Answer answer in player.answers) {
      if (answer.isGood()) {
        player.scoreInPoint += answer.question.points;
      }
    }
    return player.scoreInPoint;
  }
}
