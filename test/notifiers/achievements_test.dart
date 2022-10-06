import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jernal/data/notifiers/game.dart';
import 'package:jernal/widgets/common/achievements_ticker.dart';
import 'package:provider/provider.dart';

import '../extensions.dart';
import '../setup.dart';

void main() {
  group("achievements", () {
    final controller = TextEditingController();
    final journalDao = JournalDaoMock();
    const achievements = Achievement.values;

    void testAchievement(GameNotifier notifier, Achievement achievement) {
      final levelPointsText = achievement.requiredPoints.map((_) => "a").join();
      controller.text = levelPointsText;
      final actualLevel =
          Achievement.values.indexOf(notifier.achievements.last);
      expect(Achievement.values.indexOf(achievement), actualLevel,
          reason:
              "not the correct level: ${notifier.points} should be ${notifier.achievements.last}, but level was $achievement");
    }

    testWidgets("test achievement: 2", (tester) async {
      await tester.pumpWidget(
        buildTestScaffold(
          journalDao: journalDao,
          child: AchievementsTicker(controller: controller),
        ),
      );
      await tester.pumpAndSettle();
      final BuildContext context = tester.element(find.byType(MaterialApp));
      final notifier = Provider.of<GameNotifier>(context, listen: false);

      testAchievement(notifier, achievements[2]);
    });

    testWidgets("test achievement: last", (tester) async {
      await tester.pumpWidget(
        buildTestScaffold(
          journalDao: journalDao,
          child: AchievementsTicker(controller: controller),
        ),
      );
      await tester.pumpAndSettle();
      final BuildContext context = tester.element(find.byType(MaterialApp));
      final notifier = Provider.of<GameNotifier>(context, listen: false);

      testAchievement(notifier, achievements.last);
    });
  });
}
