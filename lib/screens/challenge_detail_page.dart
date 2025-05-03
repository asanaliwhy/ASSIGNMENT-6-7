import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChallengeDetailPage extends StatefulWidget {
  final String title;
  final Function(double) onProgressUpdate;
  final Function(int) onMinutesUpdate;  // Callback to update the profile's minutes

  ChallengeDetailPage({required this.title, required this.onProgressUpdate, required this.onMinutesUpdate});

  @override
  _ChallengeDetailPageState createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  List<List<Map<String, dynamic>>> workouts = [
    [
      {'name': 'Push-ups', 'duration': '3 sets of 15 reps', 'time': 30, 'isCompleted': false},
      {'name': 'Squats', 'duration': '3 sets of 20 reps', 'time': 25, 'isCompleted': false},
      {'name': 'Plank', 'duration': '3 sets of 30 seconds', 'time': 20, 'isCompleted': false},
    ],
    // Other weeks...
  ];

  int totalTimeSpent = 0;
  int totalChallengeDuration = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  // Load progress from SharedPreferences (e.g., if user had completed some tasks earlier)
  Future<void> _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int weekIndex = 0; weekIndex < workouts.length; weekIndex++) {
      for (int index = 0; index < workouts[weekIndex].length; index++) {
        bool? isCompleted = prefs.getBool('${widget.title}_week_${weekIndex}_exercise_${index}');
        if (isCompleted != null) {
          workouts[weekIndex][index]['isCompleted'] = isCompleted;
        }
      }
    }

    setState(() {
      _calculateChallengeProgress();
    });
  }

  // Save progress in SharedPreferences
  Future<void> _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int completedExercises = 0;
    int totalExercises = 0;

    for (var week in workouts) {
      for (var workout in week) {
        totalExercises++;
        if (workout['isCompleted']) {
          completedExercises++;
        }
      }
    }

    // Calculate progress percentage
    double progress = (completedExercises / totalExercises) * 100;
    widget.onProgressUpdate(progress); // Send progress update to MainPage

    // Save each exercise completion state
    for (int weekIndex = 0; weekIndex < workouts.length; weekIndex++) {
      for (int index = 0; index < workouts[weekIndex].length; index++) {
        await prefs.setBool(
          '${widget.title}_week_${weekIndex}_exercise_${index}',
          workouts[weekIndex][index]['isCompleted'],
        );
      }
    }

    // ✅ If all exercises are completed, increase challengesCompleted
    if (completedExercises == totalExercises) {
      int challengesCompleted = prefs.getInt('challengesCompleted') ?? 0;
      challengesCompleted += 1;
      await prefs.setInt('challengesCompleted', challengesCompleted);
      print("Challenge Completed! Total Challenges: $challengesCompleted");
    }
  }


  // Calculate challenge progress
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

    double progress = totalChallengeDuration > 0
        ? (totalTimeSpent / totalChallengeDuration)
        : 0.0;

    widget.onProgressUpdate(progress * 100); // Update overall progress
  }

  double calculateProgress() {
    if (totalChallengeDuration == 0) return 0.0;
    return totalTimeSpent / totalChallengeDuration.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overall Progress",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: calculateProgress(),
              backgroundColor: Colors.grey[300],
              color: Colors.deepPurple,
            ),
            SizedBox(height: 16),
            Column(
              children: List.generate(workouts.length, (weekIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Week ${weekIndex + 1}',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: workouts[weekIndex].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> workout = workouts[weekIndex][index];
                        bool isCompleted = workout['isCompleted'];

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(
                              isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: isCompleted ? Colors.green : Colors.grey,
                              size: 30,
                            ),
                            title: Text(workout['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${workout['duration']} - Total Duration: ${workout['time']} min'),
                            trailing: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  workout['isCompleted'] = !workout['isCompleted'];
                                  int minutesToUpdate = workout['isCompleted'] ? workout['time'] : -workout['time'];

                                  print("Updating minutes by: $minutesToUpdate"); // Debugging
                                  widget.onMinutesUpdate(minutesToUpdate);
                                });

                                _saveProgress();
                                _calculateChallengeProgress();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue,
                                side: BorderSide(color: Colors.blue, width: 2),
                              ),
                              child: Text(workout['isCompleted'] ? 'Completed' : 'Done'),
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