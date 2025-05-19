import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_2/generated/l10n.dart';

class WorkoutDetailPage extends StatefulWidget {
  final String title;
  final Function(double) onProgressUpdate;

  const WorkoutDetailPage({required this.title, required this.onProgressUpdate, super.key});

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> with TickerProviderStateMixin {
  List<List<Map<String, dynamic>>> workoutPlans(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return [
      [
        {'name': localizations.pushUpsName, 'duration': localizations.pushUpsDuration, 'time': 30, 'isCompleted': false},
        {'name': localizations.squatsName, 'duration': localizations.squatsDuration, 'time': 25, 'isCompleted': false},
        {'name': localizations.plankName, 'duration': localizations.plankDuration, 'time': 20, 'isCompleted': false},
      ],
      [
        {'name': localizations.burpeesName, 'duration': localizations.burpeesDuration, 'time': 35, 'isCompleted': false},
        {'name': localizations.lungesName, 'duration': localizations.lungesDuration, 'time': 40, 'isCompleted': false},
        {'name': localizations.mountainClimbersName, 'duration': localizations.mountainClimbersDuration, 'time': 30, 'isCompleted': false},
      ],
      [
        {'name': localizations.jumpingJacksName, 'duration': localizations.jumpingJacksDuration, 'time': 25, 'isCompleted': false},
        {'name': localizations.highKneesName, 'duration': localizations.highKneesDuration, 'time': 20, 'isCompleted': false},
        {'name': localizations.squatsName, 'duration': localizations.squatsDuration, 'time': 30, 'isCompleted': false},
      ],
      [
        {'name': localizations.pushUpsName, 'duration': localizations.pushUpsDuration, 'time': 30, 'isCompleted': false},
        {'name': localizations.plankName, 'duration': localizations.plankDuration, 'time': 20, 'isCompleted': false},
        {'name': localizations.squatsName, 'duration': localizations.squatsDuration, 'time': 25, 'isCompleted': false},
      ],
    ];
  }

  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _controllers = [];
    _slideAnimations = [];
    for (int i = 0; i < workoutPlans(context).length; i++) {
      for (int j = 0; j < workoutPlans(context)[i].length; j++) {
        final controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
        final slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeOut),
        );
        _controllers.add(controller);
        _slideAnimations.add(slideAnimation);
        Future.delayed(Duration(milliseconds: 100 * (i * workoutPlans(context)[i].length + j)), () => controller.forward());
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    for (int weekIndex = 0; weekIndex < workoutPlans(context).length; weekIndex++) {
      for (int index = 0; index < workoutPlans(context)[weekIndex].length; index++) {
        final isCompleted = prefs.getBool('${widget.title}_week_${weekIndex}_exercise_$index');
        if (isCompleted != null) {
          setState(() {
            workoutPlans(context)[weekIndex][index]['isCompleted'] = isCompleted;
          });
        }
      }
    }
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    int completedExercises = 0;
    int totalExercises = 0;

    for (var week in workoutPlans(context)) {
      for (var workout in week) {
        totalExercises++;
        if (workout['isCompleted'] as bool) {
          completedExercises++;
        }
      }
    }

    final progress = (completedExercises / totalExercises) * 100;
    widget.onProgressUpdate(progress);

    for (int weekIndex = 0; weekIndex < workoutPlans(context).length; weekIndex++) {
      for (int index = 0; index < workoutPlans(context)[weekIndex].length; index++) {
        await prefs.setBool('${widget.title}_week_${weekIndex}_exercise_$index', workoutPlans(context)[weekIndex][index]['isCompleted'] as bool);
      }
    }

    if (completedExercises == totalExercises) {
      final workoutsCompleted = prefs.getInt('workoutsCompleted') ?? 0;
      await prefs.setInt('workoutsCompleted', workoutsCompleted + 1);
    }
  }

  double calculateProgress() {
    int totalDuration = 0;
    int totalSpent = 0;
    for (var week in workoutPlans(context)) {
      for (var workout in week) {
        final time = workout['time'] as int;
        totalDuration += time;
        if (workout['isCompleted'] as bool) {
          totalSpent += time;
        }
      }
    }
    return totalDuration == 0 ? 0.0 : totalSpent / totalDuration.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), backgroundColor: Colors.deepPurple),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations.overallProgress, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: calculateProgress(), backgroundColor: Colors.grey[300], color: Colors.deepPurple),
            const SizedBox(height: 16),
            Column(
              children: List.generate(workoutPlans(context).length, (weekIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(localizations.weekNumber(weekIndex + 1), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: workoutPlans(context)[weekIndex].length,
                      itemBuilder: (context, index) {
                        final workout = workoutPlans(context)[weekIndex][index];
                        final isCompleted = workout['isCompleted'] as bool;
                        final animationIndex = weekIndex * workoutPlans(context)[weekIndex].length + index;

                        return SlideTransition(
                          position: _slideAnimations[animationIndex],
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Icon(
                                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                color: isCompleted ? Colors.green : Colors.grey,
                                size: 30,
                              ),
                              title: Text(workout['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text('${workout['duration']} - ${localizations.totalDurationLabel} ${workout['time']} ${localizations.minutesLabel}'),
                              trailing: AnimatedDoneButton(
                                isCompleted: isCompleted,
                                onPressed: () async {
                                  final prefs = await SharedPreferences.getInstance();
                                  setState(() {
                                    workout['isCompleted'] = !isCompleted;
                                  });
                                  final minutesToUpdate = (workout['isCompleted'] as bool) ? (workout['time'] as int) : -(workout['time'] as int);
                                  var totalMinutes = (prefs.getInt('totalMinutes') ?? 0) + minutesToUpdate;
                                  totalMinutes = totalMinutes.clamp(0, double.infinity).toInt();
                                  await prefs.setInt('totalMinutes', totalMinutes);
                                  await _saveProgress();
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedDoneButton extends StatefulWidget {
  final bool isCompleted;
  final VoidCallback onPressed;

  const AnimatedDoneButton({required this.isCompleted, required this.onPressed, super.key});

  @override
  _AnimatedDoneButtonState createState() => _AnimatedDoneButtonState();
}

class _AnimatedDoneButtonState extends State<AnimatedDoneButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isTapped = true),
      onTapUp: (_) {
        setState(() => _isTapped = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isTapped = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isTapped ? 0.95 : 1.0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isTapped ? Colors.blue.withOpacity(0.7) : Colors.white,
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.isCompleted ? localizations.completed : localizations.done,
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}