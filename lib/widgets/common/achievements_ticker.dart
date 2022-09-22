import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/game.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:provider/provider.dart';

class AchievementsTicker extends StatefulWidget {
  const AchievementsTicker({super.key, required this.controller, this.size});

  final TextEditingController controller;
  final Size? size;

  @override
  State<AchievementsTicker> createState() => _AchievementsTickerState();
}

class _AchievementsTickerState extends State<AchievementsTicker>
    with SingleTickerProviderStateMixin {
  int lastAchievementPoints = 0;
  int lastPoints = 0;
  late AnimationController animController;
  late Tween<double> animation;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameNotifier>(
      builder: (context, notifier, _) {
        final achievement =
            notifier.achievements.isEmpty ? null : notifier.achievements.last;

        if ((achievement?.requiredPoints ?? 0) > lastAchievementPoints) {
          animController.reset();
          animController.forward();
        } else if (lastPoints < notifier.points) {
          animController.reset();
          animController.forward(from: 0.75);
        }
        lastPoints = notifier.points;
        lastAchievementPoints = achievement?.requiredPoints ?? 0;

        final nextAchievement = notifier.nextAchievment;
        final points = notifier.points;
        final nextAchievementPoints =
            nextAchievement?.requiredPoints.toDouble() ?? points;
        final level = (achievement != null
            ? Achievement.values.indexOf(achievement) + 1
            : 0);
        final over = points - lastAchievementPoints;
        final space = nextAchievementPoints - lastAchievementPoints;
        var value = over.toDouble() / space.toDouble();
        if (value == 0 && points != 0) {
          value = 1.0;
        }
        final color = achievement?.color;
        return Visibility(
          visible: level > 0,
          child: AnimatedBuilder(
            animation: animController,
            builder: (context, _) {
              var fraction = animController.value;
              if (fraction >= 0.5) {
                fraction = 0.5 - (fraction - 0.5);
              }
              return Container(
                width: widget.size?.width ?? 100,
                height: widget.size?.height ?? 100,
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: 1 + fraction,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            value: value,
                            strokeWidth: 3.0,
                            color: color,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          level.toString(),
                          style: context.theme.textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void onTextChanged() {
    final text = widget.controller.text;
    if (mounted) {
      GameNotifier.setPointsWith(context, text.length);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onTextChanged);
    animController = AnimationController(vsync: this);
    animController.duration = const Duration(milliseconds: 500);
    animation = Tween(begin: 0.0, end: 1.0);
    animation.animate(animController);
    animController.forward();
  }

  @override
  void dispose() {
    widget.controller.removeListener(onTextChanged);
    animController.dispose();
    super.dispose();
  }
}
