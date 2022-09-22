import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameNotifier extends ChangeNotifier {
  int _points = 0;
  int get points => _points;

  List<Achievement> _achievements = [];
  List<Achievement> get achievements => _achievements;

  Achievement? get nextAchievment => Achievement.values
      .firstWhereOrNull((element) => element.requiredPoints > points);

  void setPoints(int points) {
    final prevPoints = _points;
    _points = points;
    _achievements = Achievement.collect(points);
    if (!outsideScoring(points) || !outsideScoring(prevPoints)) {
      notifyListeners();
    }
  }

  bool outsideScoring(int myPoints) =>
      myPoints > Achievement.values.last.requiredPoints;

  static void setPointsWith(BuildContext context, int points) =>
      Provider.of<GameNotifier>(context, listen: false).setPoints(points);
}

enum Achievement {
  starter(
    1,
    "Starter",
    "Great! You've started! Keep going!",
    Color.fromARGB(255, 126, 221, 147),
  ),
  introvert(
    25,
    "Introvert",
    "You're on your way! Go!",
    Color.fromARGB(255, 112, 183, 136),
  ),
  extrovert(
    75,
    "Extrovert",
    "Wow, you're really good at this!",
    Color.fromARGB(255, 241, 201, 54),
  ),
  anchor(
    200,
    "Anchor",
    "You can write! Keep it up!",
    Color.fromARGB(255, 210, 127, 38),
  ),
  author(
    500,
    "Author",
    "Working on your new book huh?",
    Color.fromARGB(255, 182, 52, 52),
  ),
  writer(
    1000,
    "Writer",
    "You've made it! You're a writer!",
    Color.fromARGB(255, 108, 50, 180),
  ),
  jernalist(
    5000,
    "Jernalist",
    "UNLIMITED",
    Color.fromARGB(255, 135, 205, 253),
  ),
  ;

  static List<Achievement> collect(int points) {
    final achievements = <Achievement>[];
    for (var achievement in Achievement.values) {
      if (points >= achievement.requiredPoints) {
        achievements.add(achievement);
      }
    }
    return achievements;
  }

  final int requiredPoints;
  final String title;
  final String message;
  final Color color;
  const Achievement(this.requiredPoints, this.title, this.message, this.color);
}
