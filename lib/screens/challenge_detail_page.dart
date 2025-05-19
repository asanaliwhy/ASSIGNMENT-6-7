import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_2/generated/l10n.dart';

class ChallengeDetailPage extends StatefulWidget {
  final String title;
  final Function(double) onProgressUpdate;
  final Function(int) onMinutesUpdate;

  const ChallengeDetailPage({
    required this.title,
    required this.onProgressUpdate,
    required this.onMinutesUpdate,
    super.key,
  });

  @override
  _ChallengeDetailPageState createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> with TickerProviderStateMixin {
  late List<List<Map<String, dynamic>>> workouts;
  int totalTimeSpent = 0;
  int totalChallengeDuration = 0;
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    switch (widget.title) {
      case 'cardioBlastTitle':
        workouts = [
          [
            {'name': 'jumpingJacksName', 'duration': 'jumpingJacksDuration', 'time': 25, 'isCompleted': false},
            {'name': 'highKneesName', 'duration': 'highKneesDuration', 'time': 20, 'isCompleted': false},
            {'name': 'burpeesName', 'duration': 'burpeesDuration', 'time': 35, 'isCompleted': false},
          ],
        ];
        break;
      case 'fullBodyChallengeTitle':
        workouts = [
          [
            {'name': 'pushUpsName', 'duration': 'pushUpsDuration', 'time': 30, 'isCompleted': false},
            {'name': 'squatsName', 'duration': 'squatsDuration', 'time': 25, 'isCompleted': false},
            {'name': 'plankName', 'duration': 'plankDuration', 'time': 20, 'isCompleted': false},
          ],
        ];
        break;
      case 'plankChallengeTitle':
        workouts = [
          [
            {'name': 'standardPlankName', 'duration': 'standardPlankDuration', 'time': 20, 'isCompleted': false},
            {'name': 'sidePlankName', 'duration': 'sidePlankDuration', 'time': 15, 'isCompleted': false},
            {'name': 'plankWithLegLiftName', 'duration': 'plankWithLegLiftDuration', 'time': 15, 'isCompleted': false},
          ],
        ];
        break;
      case 'fitIn15Title':
        workouts = [
          [
            {'name': 'mountainClimbersName', 'duration': 'mountainClimbersDuration', 'time': 20, 'isCompleted': false},
            {'name': 'lungesName', 'duration': 'lungesDuration', 'time': 25, 'isCompleted': false},
            {'name': 'bicycleCrunchesName', 'duration': 'bicycleCrunchesDuration', 'time': 20, 'isCompleted': false},
          ],
        ];
        break;
      default:
        workouts = [
          [
            {'name': 'pushUpsName', 'duration': 'pushUpsDuration', 'time': 30, 'isCompleted': false},
            {'name': 'squatsName', 'duration': 'squatsDuration', 'time': 25, 'isCompleted': false},
            {'name': 'plankName', 'duration': 'plankDuration', 'time': 20, 'isCompleted': false},
          ],
        ];
    }

    _loadProgress();
    _controllers = [];
    _slideAnimations = [];
    for (int i = 0; i < workouts.length; i++) {
      for (int j = 0; j < workouts[i].length; j++) {
        final controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
        final slideAnimation = Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeOut),
        );
        _controllers.add(controller);
        _slideAnimations.add(slideAnimation);
        Future.delayed(Duration(milliseconds: 100 * (i * workouts[i].length + j)), () => controller.forward());
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
    print('Loading progress for ${widget.title}');
    for (int weekIndex = 0; weekIndex < workouts.length; weekIndex++) {
      for (int index = 0; index < workouts[weekIndex].length; index++) {
        final key = '${widget.title}_week_${weekIndex}_exercise_$index';
        final isCompleted = prefs.getBool(key) ?? false;
        print('Loaded $key: $isCompleted');
        setState(() {
          workouts[weekIndex][index]['isCompleted'] = isCompleted;
        });
      }
    }
    setState(() {
      _calculateChallengeProgress();
    });
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    int completedExercises = 0;
    int totalExercises = 0;

    for (int weekIndex = 0; weekIndex < workouts.length; weekIndex++) {
      final week = workouts[weekIndex];
      for (int exerciseIndex = 0; exerciseIndex < week.length; exerciseIndex++) {
        final workout = week[exerciseIndex];
        totalExercises++;
        if (workout['isCompleted'] == true) {
          completedExercises++;
        }
        final key = '${widget.title}_week_${weekIndex}_exercise_$exerciseIndex';
        await prefs.setBool(key, workout['isCompleted'] as bool);
        print('Saved $key: ${workout['isCompleted']}');
      }
    }

    final progress = totalExercises == 0 ? 0.0 : (completedExercises / totalExercises) * 100;
    print('Saving progress for ${widget.title}: $progress%');
    await prefs.setDouble('challenge_${widget.title}', progress);
    widget.onProgressUpdate(progress);

    if (completedExercises == totalExercises) {
      final challengesCompleted = prefs.getInt('challengesCompleted') ?? 0;
      await prefs.setInt('challengesCompleted', challengesCompleted + 1);
    }
  }

  void _calculateChallengeProgress() {
    totalTimeSpent = 0;
    totalChallengeDuration = 0;
    for (var week in workouts) {
      for (var workout in week) {
        totalChallengeDuration += workout['time'] as int;
        if (workout['isCompleted'] == true) {
          totalTimeSpent += workout['time'] as int;
        }
      }
    }
  }

  double calculateProgress() => totalChallengeDuration == 0 ? 0.0 : totalTimeSpent / totalChallengeDuration.toDouble();

  String _getTranslatedTitle(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (widget.title) {
      case 'cardioBlastTitle':
        return localizations.cardioBlastTitle;
      case 'fullBodyChallengeTitle':
        return localizations.fullBodyChallengeTitle;
      case 'plankChallengeTitle':
        return localizations.plankChallengeTitle;
      case 'fitIn15Title':
        return localizations.fitIn15Title;
      default:
        return widget.title; // Fallback for unknown titles
    }
  }

  String _getTranslatedWorkoutName(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;
    switch (key) {
      case 'jumpingJacksName':
        return localizations.jumpingJacksName;
      case 'highKneesName':
        return localizations.highKneesName;
      case 'burpeesName':
        return localizations.burpeesName;
      case 'pushUpsName':
        return localizations.pushUpsName;
      case 'squatsName':
        return localizations.squatsName;
      case 'plankName':
        return localizations.plankName;
      case 'standardPlankName':
        return localizations.standardPlankName;
      case 'sidePlankName':
        return localizations.sidePlankName;
      case 'plankWithLegLiftName':
        return localizations.plankWithLegLiftName;
      case 'mountainClimbersName':
        return localizations.mountainClimbersName;
      case 'lungesName':
        return localizations.lungesName;
      case 'bicycleCrunchesName':
        return localizations.bicycleCrunchesName;
      default:
        return key; // Fallback for unknown keys
    }
  }

  String _getTranslatedWorkoutDuration(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;
    switch (key) {
      case 'jumpingJacksDuration':
        return localizations.jumpingJacksDuration;
      case 'highKneesDuration':
        return localizations.highKneesDuration;
      case 'burpeesDuration':
        return localizations.burpeesDuration;
      case 'pushUpsDuration':
        return localizations.pushUpsDuration;
      case 'squatsDuration':
        return localizations.squatsDuration;
      case 'plankDuration':
        return localizations.plankDuration;
      case 'standardPlankDuration':
        return localizations.standardPlankDuration;
      case 'sidePlankDuration':
        return localizations.sidePlankDuration;
      case 'plankWithLegLiftDuration':
        return localizations.plankWithLegLiftDuration;
      case 'mountainClimbersDuration':
        return localizations.mountainClimbersDuration;
      case 'lungesDuration':
        return localizations.lungesDuration;
      case 'bicycleCrunchesDuration':
        return localizations.bicycleCrunchesDuration;
      default:
        return key; // Fallback for unknown keys
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(_getTranslatedTitle(context)), backgroundColor: Colors.deepPurple),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations.overallProgress, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            LinearProgressIndicator(value: calculateProgress(), backgroundColor: Colors.grey[300], color: Colors.deepPurple),
            SizedBox(height: 16),
            Column(
              children: List.generate(workouts.length, (weekIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(localizations.weekNumber(weekIndex + 1), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: workouts[weekIndex].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> workout = workouts[weekIndex][index];
                        bool isCompleted = workout['isCompleted'];
                        int animationIndex = weekIndex * workouts[weekIndex].length + index;

                        return SlideTransition(
                          position: _slideAnimations[animationIndex],
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Icon(
                                isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                                color: isCompleted ? Colors.green : Colors.grey,
                                size: 30,
                              ),
                              title: Text(
                                _getTranslatedWorkoutName(context, workout['name']),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${_getTranslatedWorkoutDuration(context, workout['duration'])} - Total Duration: ${workout['time']} min',
                              ),
                              trailing: AnimatedDoneButton(
                                isCompleted: isCompleted,
                                onPressed: () {
                                  setState(() {
                                    workout['isCompleted'] = !workout['isCompleted'];
                                    int minutesToUpdate = workout['isCompleted'] ? workout['time'] : -workout['time'];
                                    widget.onMinutesUpdate(minutesToUpdate);
                                  });
                                  _saveProgress();
                                  _calculateChallengeProgress();
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
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
        duration: Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isTapped ? 0.95 : 1.0),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isTapped ? Colors.blue.withOpacity(0.7) : Colors.white,
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          widget.isCompleted ? localizations.completed : localizations.done,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}