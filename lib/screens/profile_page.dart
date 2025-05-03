import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'exercise_detail_page.dart';
import 'challenge_detail_page.dart';
import 'workout_detail_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userName = "User";
  final String profileImage = "assets/profile.jpg";
  int workoutsCompleted = 0;
  int totalMinutes = 0;
  int challengesCompleted = 0;

  List<Map<String, dynamic>> fitnessGoals = [];
  final TextEditingController _goalController = TextEditingController();

  List<Map<String, String>> favoriteExercises = [];

  _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteList = prefs.getStringList('favoriteExercises') ?? [];
    setState(() {
      favoriteExercises = favoriteList
          .map((item) => Map<String, String>.from(jsonDecode(item)))
          .toList();
    });
  }

  void updateWorkoutsCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedWorkouts = prefs.getInt('workoutsCompleted') ?? 0;
    setState(() {
      workoutsCompleted = savedWorkouts;
    });
  }
  void updateChallengesCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedChallenges = prefs.getInt('challengesCompleted') ?? 0;
    setState(() {
      challengesCompleted = savedChallenges;
    });
  }


  void _loadWorkoutsCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedWorkouts = prefs.getInt('workoutsCompleted') ?? 0;
    setState(() {
      workoutsCompleted = savedWorkouts;
    });
  }

  void _loadChallengesCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedChallenges = prefs.getInt('challengesCompleted') ?? 0;
    setState(() {
      challengesCompleted = savedChallenges;
    });
  }




  // Load total minutes from SharedPreferences
  _loadTotalMinutes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedMinutes = prefs.getInt('totalMinutes') ?? 0;
    print("Loaded total minutes from storage: $savedMinutes");  // Debugging
    setState(() {
      totalMinutes = savedMinutes;
    });
  }


  // This method will update the total minutes
  void updateTotalMinutes(int minutes) async {
    setState(() {
      totalMinutes += minutes;
    });

    print("Total minutes updated to: $totalMinutes"); // Debugging
    await _saveTotalMinutes();
  }


  // Save total minutes to SharedPreferences
  _saveTotalMinutes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Saving total minutes: $totalMinutes"); // Debugging
    await prefs.setInt('totalMinutes', totalMinutes);
  }


  // Load goals from SharedPreferences
  _loadGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? goalsString = prefs.getString('fitnessGoals');
    if (goalsString != null) {
      List<dynamic> goalsJson = jsonDecode(goalsString);
      setState(() {
        fitnessGoals = goalsJson
            .map((goal) => {
          'goal': goal['goal'],
          'progress': goal['progress'],
        })
            .toList();
      });
    }
  }

  // Save goals to SharedPreferences
  _saveGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String goalsString = jsonEncode(fitnessGoals);
    prefs.setString('fitnessGoals', goalsString);
  }

  // Add a new goal with default 0% progress
  _addGoal() {
    if (_goalController.text.isNotEmpty) {
      setState(() {
        fitnessGoals.add({
          'goal': _goalController.text,
          'progress': 0.0,
        });
        _goalController.clear();
        _saveGoals();  // Save goals after adding
      });
    }
  }

  // Edit an existing goal
  _editGoal(int index) {
    _goalController.text = fitnessGoals[index]['goal'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Goal"),
          content: TextField(
            controller: _goalController,
            decoration: InputDecoration(labelText: "Goal"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  fitnessGoals[index]['goal'] = _goalController.text;
                  _saveGoals();  // Save goals after editing
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Delete an existing goal
  _deleteGoal(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Goal"),
          content: Text("Are you sure you want to delete this goal?"),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  fitnessGoals.removeAt(index);
                  _saveGoals();  // Save goals after deletion
                });
                Navigator.pop(context);
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }

  // Adjust progress (increase or decrease)
  _adjustProgress(int index, double delta) {
    setState(() {
      fitnessGoals[index]['progress'] = (fitnessGoals[index]['progress'] + delta).clamp(0.0, 1.0);
      _saveGoals();  // Save goals after adjusting progress
    });
  }

  // Display stats containers
  Widget _buildStatContainer(String label, String value, Color bgColor, Color textColor) {
    return Container(
      width: 160,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadTotalMinutes();  // Load total minutes when the page is initialized
    _loadGoals();
    _loadFavorites();
    _loadWorkoutsCompleted();
    _loadChallengesCompleted();// Load favorites
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(profileImage),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildStatContainer("Workouts", workoutsCompleted.toString(), Colors.green[200]!, Colors.green[800]!),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatContainer("Minutes", totalMinutes.toString(), Colors.blue[200]!, Colors.blue[800]!),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatContainer("Challenges", challengesCompleted.toString(), Colors.red[200]!, Colors.red[800]!),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Add Goal Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _goalController,
                  decoration: InputDecoration(labelText: "Enter your goal"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _addGoal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Add Goal",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // ✅ color goes here
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Fitness Goals Section
            Text(
              "Fitness Goals",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),

            // Display the goals
            Column(
              children: List.generate(fitnessGoals.length, (index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              fitnessGoals[index]['goal'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editGoal(index),
                              color: Colors.orange,
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteGoal(index),
                              color: Colors.red,
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: fitnessGoals[index]['progress'],
                          backgroundColor: Colors.grey[300],
                          color: Colors.deepPurple,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${(fitnessGoals[index]['progress'] * 100).toInt()}% Complete",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => _adjustProgress(index, -0.05),
                              color: Colors.blue,
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => _adjustProgress(index, 0.05),
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),

            Text(
              "Favorites",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 16),

            Column(
              children: favoriteExercises.map((exercise) {
                return Card(
                  elevation: 0,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExerciseDetailPage(
                            name: exercise['name']!,
                            steps: exercise['steps']!,
                            imageUrl: exercise['image']!,
                            bodyPart: exercise['bodyPart']!,
                            equipment: exercise['equipment']!,
                            difficulty: exercise['difficulty']!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: Image.asset(
                          exercise['image']!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          exercise['name']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        subtitle: Text(exercise['bodyPart'] ?? ''),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
