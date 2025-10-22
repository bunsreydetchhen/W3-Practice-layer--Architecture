import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int points;

  Question({
    String? id,
    required this.title,
    required this.choices,
    required this.goodChoice,
    this.points = 1,
  }) : id = id ?? uuid.v4();

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      choices: List<String>.from(json['choices']),
      goodChoice: json['goodChoice'],
      points: json['points'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'choices': choices,
        'goodChoice': goodChoice,
        'points': points,
      };
}

class Answer {
  final String id;
  final String questionId;
  final String answerChoice;

  Answer({
    String? id,
    required this.questionId,
    required this.answerChoice,
  }) : id = id ?? uuid.v4();

  bool isGood(Question question) => answerChoice == question.goodChoice;

  Map<String, dynamic> toJson() => {
        'id': id,
        'questionId': questionId,
        'answerChoice': answerChoice,
      };
}

class Quiz {
  final String id;
  List<Question> questions;
  List<Answer> answers = [];

  Quiz({
    String? id,
    required this.questions,
  }) : id = id ?? uuid.v4();

  void addAnswer(Answer answer) => answers.add(answer);

  Question getQuestionById(String questionId) {
    return questions.firstWhere(
      (q) => q.id == questionId,
      orElse: () => throw Exception('Question not found'),
    );
  }

  int getEarnedPoints() {
    int total = 0;
    for (var answer in answers) {
      var question = getQuestionById(answer.questionId);
      if (answer.isGood(question)) total += question.points;
    }
    return total;
  }

  int getPossiblePoints() =>
      questions.fold(0, (sum, q) => sum + q.points);

  int getScoreInPercentage() {
    if (questions.isEmpty) return 0;
    return ((getEarnedPoints() / getPossiblePoints()) * 100).toInt();
  }

  void reset() => answers = [];

  factory Quiz.fromJson(Map<String, dynamic> json) {
    var questionsJson = json['questions'] as List;
    var questions = questionsJson.map((q) => Question.fromJson(q)).toList();
    return Quiz(id: json['id'], questions: questions);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'questions': questions.map((q) => q.toJson()).toList(),
      };
}

class Player {
  final String name;
  int lastScore = 0;
  int lastPoints = 0;

  Player(this.name);
}

class QuizFinished {
  final Player player;
  final int earnedPoints;
  final int possiblePoints;

  QuizFinished({
    required this.player,
    required this.earnedPoints,
    required this.possiblePoints,
  });

  int getScoreInPercentage() {
    if (possiblePoints == 0) return 0;
    return ((earnedPoints / possiblePoints) * 100).toInt();
  }

  @override
  String toString() {
    return "${player.name}: $earnedPoints/$possiblePoints points (${getScoreInPercentage()}%)";
  }
}

class Scoreboard {
  final Map<String, QuizFinished> _results = {};

  void recordResult(QuizFinished result) {
    _results[result.player.name] = result;
  }

  List<QuizFinished> get allResults => _results.values.toList();

  void showResults() {
    print("\n--- SCOREBOARD ---");
    if (_results.isEmpty) {
      print("No players yet.");
      return;
    }
    for (var result in _results.values) {
      print(result.toString());
    }
  }
}
