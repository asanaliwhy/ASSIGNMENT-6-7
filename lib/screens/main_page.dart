import 'package:flutter/material.dart';
import 'package:final_2/screens/challenge_detail_page.dart';
import 'package:final_2/screens/workout_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_2/map/map_page.dart'; // Assuming MapPage is for displaying gym location

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int started = 0;
  int completed = 0;

  final List<Map<String, String>> challenges = [
    {
      'title': 'Full Body Challenge',
      'subtitle': 'Complete Body Focus',
      'image': 'assets/full_body.jpeg',
      'progress': '0',
    },
    {
      'title': 'Plank Challenge',
      'subtitle': 'Build Core Strength',
      'image': 'assets/plank.jpg',
      'progress': '0',
    },
    {
      'title': 'Fit in 15',
      'subtitle': 'Quick Daily Workouts',
      'image': 'assets/fit15.jpeg',
      'progress': '0',
    },
    {
      'title': 'Cardio Blast',
      'subtitle': 'Burn Calories Fast',
      'image': 'assets/cardio.jpg',
      'progress': '0',
    },
  ];

  final List<Map<String, String>> gymsNearMe = [
    {
      'title': 'Gold\'s Gym Venice',
      'subtitle': 'The Mecca of Bodybuilding',
      'image': 'assets/golden_gym.jpg',
      'address': '360 Hampton Dr, Venice',
      'latitude': '33.9939',
      'longitude': '-118.4698'
    },
    {
      'title': 'Planet Fitness',
      'subtitle': 'Affordable and local',
      'image': 'assets/planet_fitness.jpg',
      'address': '456 Fitness Rd, HealthyTown',
      'latitude': '40.7565',
      'longitude': '-73.9882'
    },
  ];

  final List<Map<String, String>> workouts = [
    {
      'title': 'Chest workout',
      'duration': '330 minutes',
      'image': 'assets/chest_workout.jpeg',
    },
    {
      'title': 'Leg workout',
      'duration': '330 minutes',
      'image': 'assets/leg_workout.jpeg',
    },
    {
      'title': 'Plank',
      'duration': '330 minutes',
      'image': 'assets/plank.jpg',
    },
    {
      'title': 'Back workout',
      'duration': '330 minutes',
      'image': 'assets/back_workout.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  void loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < challenges.length; i++) {
      double? savedProgress = prefs.getDouble('challenge_${challenges[i]['title']}');
      if (savedProgress != null) {
        setState(() {
          challenges[i]['progress'] = savedProgress.toStringAsFixed(0);
        });
      }
    }

    setState(() {
      started = prefs.getInt('started_workouts') ?? 0;
      completed = prefs.getInt('completed_workouts') ?? 0;
    });
  }

  void saveProgress(int index, double newProgress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      challenges[index]['progress'] = newProgress.toStringAsFixed(0);
    });
    prefs.setDouble('challenge_${challenges[index]['title']}', newProgress);
    print('Progress saved for ${challenges[index]['title']}: $newProgress');
  }

  int getCompletedWorkouts() {
    return challenges.where((c) => double.parse(c['progress']!) == 100).length;
  }

  int getStartedWorkouts() {
    return challenges.where((c) => double.parse(c['progress']!) > 0).length;
  }

  void updateTotalMinutes(int minutes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int totalMinutes = prefs.getInt('totalMinutes') ?? 0;
    totalMinutes += minutes;
    await prefs.setInt('totalMinutes', totalMinutes);
    print("Updated total minutes: $totalMinutes");
  }

  @override
  Widget build(BuildContext context) {
    int completed = getCompletedWorkouts();
    int started = getStartedWorkouts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$started Started',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
            ),
            SizedBox(width: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$completed Completed',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[800]),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text("Challenges", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 16),
            // Challenges Section
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: challenges.length,
                itemBuilder: (context, index) {
                  final challenge = challenges[index];
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChallengeDetailPage(
                            title: challenge['title']!,
                            onProgressUpdate: (newProgress) {
                              saveProgress(index, newProgress);
                            },
                            onMinutesUpdate: (minutes) async {
                              updateTotalMinutes(minutes);
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 250,
                      margin: EdgeInsets.only(right: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              child: Image.asset(challenge['image']!, height: 160, width: double.infinity, fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    challenge['subtitle']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: double.parse(challenge['progress']!) / 100, // You can use actual progress here
                                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  Text(
                                    '${challenge['progress']}% Completed',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            // New Gyms Near Me Section
            Text("Gyms Near Me", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 16),
            // Gym Cards Section
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: gymsNearMe.length,
                itemBuilder: (context, index) {
                  final gym = gymsNearMe[index];
                  return GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MapPage(
                            gymsNearMe: [gymsNearMe[index]], // Pass only the selected gym
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 250,
                      margin: EdgeInsets.only(right: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              child: Image.asset(gym['image']!, height: 160, width: double.infinity, fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gym['title']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    gym['address']!,
                                    style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            // Workout Plans Section
            Text("Workout Plans", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            const SizedBox(height: 16),
            ListView.builder(
              itemCount: workouts.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WorkoutDetailPage(
                          title: workout['title']!,
                          onProgressUpdate: (progress) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            if (progress == 100) {
                              int completed = prefs.getInt('completed_workouts') ?? 0;
                              await prefs.setInt('completed_workouts', completed + 1);
                            }
                          },
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(workout['image']!, width: 60, height: 60, fit: BoxFit.cover),
                      title: Text(workout['title']!),
                      subtitle: Text(workout['duration']!),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
