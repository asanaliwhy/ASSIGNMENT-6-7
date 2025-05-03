import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutDetailPage extends StatefulWidget {
  final String title;
  final Function(double) onProgressUpdate;

  WorkoutDetailPage({required this.title, required this.onProgressUpdate});

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  final List<List<Map<String, dynamic>>> workoutPlans = [
    // Week 1
    [
      {'name': 'Push-ups', 'duration': '3 sets of 15 reps', 'time': 30, 'isCompleted': false},
      {'name': 'Squats', 'duration': '3 sets of 20 reps', 'time': 25, 'isCompleted': false},
      {'name': 'Plank', 'duration': '3 sets of 30 seconds', 'time': 20, 'isCompleted': false},
    ],
    // Week 2
    [
      {'name': 'Burpees', 'duration': '3 sets of 15 reps', 'time': 35, 'isCompleted': false},
      {'name': 'Lunges', 'duration': '3 sets of 20 reps', 'time': 40, 'isCompleted': false},
      {'name': 'Mountain Climbers', 'duration': '3 sets of 30 seconds', 'time': 30, 'isCompleted': false},
    ],
    // Week 3
    [
      {'name': 'Jumping Jacks', 'duration': '3 sets of 30 seconds', 'time': 25, 'isCompleted': false},
      {'name': 'High Knees', 'duration': '3 sets of 30 seconds', 'time': 20, 'isCompleted': false},
      {'name': 'Sit-ups', 'duration': '3 sets of 15 reps', 'time': 30, 'isCompleted': false},
    ],
    // Week 4
    [
      {'name': 'Push-ups', 'duration': '3 sets of 15 reps', 'time': 30, 'isCompleted': false},
      {'name': 'Plank', 'duration': '3 sets of 30 seconds', 'time': 20, 'isCompleted': false},
      {'name': 'Squats', 'duration': '3 sets of 20 reps', 'time': 25, 'isCompleted': false},
    ],
  ];

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int weekIndex = 0; weekIndex < workoutPlans.length; weekIndex++) {
      for (int index = 0; index < workoutPlans[weekIndex].length; index++) {
        bool? isCompleted = prefs.getBool('${widget.title}_week_${weekIndex}_exercise_${index}');
        if (isCompleted != null) {
          setState(() {
            workoutPlans[weekIndex][index]['isCompleted'] = isCompleted;
          });
        }
      }
    }
  }

  Future<void> _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int completedExercises = 0;
    int totalExercises = 0;

    for (var week in workoutPlans) {
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
    for (int weekIndex = 0; weekIndex < workoutPlans.length; weekIndex++) {
      for (int index = 0; index < workoutPlans[weekIndex].length; index++) {
        await prefs.setBool(
          '${widget.title}_week_${weekIndex}_exercise_${index}',
          workoutPlans[weekIndex][index]['isCompleted'],
        );
      }
    }

    // ✅ If all exercises are completed, increase workoutsCompleted
    if (completedExercises == totalExercises) {
      int workoutsCompleted = prefs.getInt('workoutsCompleted') ?? 0;
      workoutsCompleted += 1;
      await prefs.setInt('workoutsCompleted', workoutsCompleted);
      print("Workout Completed! Total Workouts: $workoutsCompleted");
    }
  }



  double calculateProgress() {
    int totalDuration = 0;
    int totalSpent = 0;

    for (var week in workoutPlans) {
      for (var workout in week) {
        totalDuration += workout['time'] as int;
        if (workout['isCompleted']) {
          totalSpent += workout['time'] as int;
        }
      }
    }

    return totalDuration == 0 ? 0.0 : totalSpent / totalDuration.toDouble();
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
            Text("Overall Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: calculateProgress(),
              backgroundColor: Colors.grey[300],
              color: Colors.deepPurple,
            ),
            SizedBox(height: 16),
            Column(
              children: List.generate(workoutPlans.length, (weekIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Week ${weekIndex + 1}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: workoutPlans[weekIndex].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> workout = workoutPlans[weekIndex][index];
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
                              onPressed: () async {
                                setState(() {
                                  workout['isCompleted'] = !isCompleted;
                                });

                                // Get the workout time
                                int minutesToUpdate = workout['isCompleted'] ? workout['time'] : -workout['time'];

                                // Ensure minutes never go below 0
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                int totalMinutes = prefs.getInt('totalMinutes') ?? 0;
                                totalMinutes = (totalMinutes + minutesToUpdate).clamp(0, double.infinity).toInt();
                                await prefs.setInt('totalMinutes', totalMinutes);

                                print("Updated total minutes: $totalMinutes");

                                _saveProgress(); // Save progress
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue,
                                side: BorderSide(color: Colors.blue, width: 2),
                              ),
                              child: Text(isCompleted ? 'Completed' : 'Done'),
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

