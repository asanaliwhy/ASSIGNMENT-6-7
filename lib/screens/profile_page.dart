import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_2/generated/l10n.dart';
import 'dart:convert';
import 'exercise_detail_page.dart';
import 'challenge_detail_page.dart';
import 'workout_detail_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "User";
  final String profileImage = "assets/profile.jpg";
  int workoutsCompleted = 0;
  int totalMinutes = 0;
  int challengesCompleted = 0;

  List<Map<String, dynamic>> fitnessGoals = [];
  final TextEditingController _goalController = TextEditingController();
  final FocusNode _goalFocusNode = FocusNode();
  String? _goalError;

  List<Map<String, String>> favoriteExercises = [];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTotalMinutes();
    _loadGoals();
    _loadFavorites();
    _loadWorkoutsCompleted();
    _loadChallengesCompleted();
  }

  @override
  void dispose() {
    _goalController.dispose();
    _goalFocusNode.dispose();
    super.dispose();
  }

  void _loadUserName() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.displayName != null && user.displayName!.isNotEmpty) {
      setState(() {
        userName = user.displayName!;
      });
    }
  }

  String _getLocalizedValue(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) {
      return {
        'pushUpsName': 'Push-Ups',
        'squatsName': 'Squats',
        'plankName': 'Plank',
        'jumpingJacksName': 'Jumping Jacks',
        'pushUpsSteps': 'Lie face down, push up...',
        'squatsSteps': 'Stand, lower hips...',
        'bodyPartChest': 'Chest',
        'bodyPartCore': 'Core',
        'bodyPartLegs': 'Legs',
        'equipmentNone': 'None',
        'equipmentMat': 'Mat',
        'beginner': 'Beginner',
        'intermediate': 'Intermediate',
        'advanced': 'Advanced',
      }[key] ?? 'Unknown';
    }
    final Map<String, String> keyMap = {
      'pushUpsName': localizations.pushUpsName,
      'squatsName': localizations.squatsName,
      'plankName': localizations.plankName,
      'jumpingJacksName': localizations.jumpingJacksName,
      'pushUpsSteps': localizations.pushUpsSteps,
      'squatsSteps': localizations.squatsSteps,
      'bodyPartChest': localizations.bodyPartChest,
      'bodyPartCore': localizations.bodyPartCore,
      'bodyPartLegs': localizations.bodyPartLegs,
      'equipmentNone': localizations.equipmentNone,
      'equipmentMat': localizations.equipmentMat,
      'beginner': localizations.beginner,
      'intermediate': localizations.intermediate,
      'advanced': localizations.advanced,
    };
    return keyMap[key] ?? 'Unknown';
  }

  Future<void> _loadFavorites() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favoriteList = prefs.getStringList('favoriteExercises') ?? [];
      List<Map<String, String>> validFavorites = [];
      List<String> cleanedFavoriteList = [];

      bool hasMigrated = prefs.getBool('hasMigratedFavorites') ?? false;
      if (!hasMigrated) {
        for (var item in favoriteList) {
          try {
            var decoded = jsonDecode(item);
            var newFormat = {
              'nameKey': (decoded['name'] ?? decoded['nameKey'] ?? 'unknown').toString(),
              'stepsKey': (decoded['steps'] ?? decoded['stepsKey'] ?? 'unknown').toString(),
              'imageUrl': (decoded['image'] ?? decoded['imageUrl'] ?? '').toString(),
              'bodyPartKey': (decoded['bodyPart'] ?? decoded['bodyPartKey'] ?? 'unknown').toString(),
              'equipmentKey': (decoded['equipment'] ?? decoded['equipmentKey'] ?? 'unknown').toString(),
              'difficultyKey': (decoded['difficulty'] ?? decoded['difficultyKey'] ?? 'unknown').toString(),
            };
            if (newFormat['nameKey'] == 'unknown' || newFormat['stepsKey'] == 'unknown') {
              continue;
            }
            cleanedFavoriteList.add(jsonEncode(newFormat));
            validFavorites.add(newFormat);
          } catch (e) {}
        }
        await prefs.setStringList('favoriteExercises', cleanedFavoriteList);
        await prefs.setBool('hasMigratedFavorites', true);
      } else {
        for (var item in favoriteList) {
          try {
            var decoded = jsonDecode(item);
            if (decoded is Map &&
                decoded['nameKey'] != null &&
                decoded['nameKey'] != 'unknown' &&
                decoded['stepsKey'] != null &&
                decoded['stepsKey'] != 'unknown' &&
                decoded['imageUrl'] != null &&
                decoded['bodyPartKey'] != null &&
                decoded['equipmentKey'] != null &&
                decoded['difficultyKey'] != null) {
              var validEntry = {
                'nameKey': decoded['nameKey'].toString(),
                'stepsKey': decoded['stepsKey'].toString(),
                'imageUrl': decoded['imageUrl'].toString(),
                'bodyPartKey': decoded['bodyPartKey'].toString(),
                'equipmentKey': decoded['equipmentKey'].toString(),
                'difficultyKey': decoded['difficultyKey'].toString(),
              };
              validFavorites.add(validEntry);
              cleanedFavoriteList.add(item);
            }
          } catch (e) {}
        }
        await prefs.setStringList('favoriteExercises', cleanedFavoriteList);
      }

      setState(() {
        favoriteExercises = validFavorites;
      });
    } catch (e) {}
  }

  Future<void> _resetFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('favoriteExercises');
    await prefs.setBool('hasMigratedFavorites', false);
    setState(() {
      favoriteExercises = [];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Favorites reset successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _loadWorkoutsCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedWorkouts = prefs.getInt('workoutsCompleted') ?? 0;
    setState(() {
      workoutsCompleted = savedWorkouts;
    });
  }

  Future<void> _loadChallengesCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedChallenges = prefs.getInt('challengesCompleted') ?? 0;
    setState(() {
      challengesCompleted = savedChallenges;
    });
  }

  Future<void> _loadTotalMinutes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedMinutes = prefs.getInt('totalMinutes') ?? 0;
    setState(() {
      totalMinutes = savedMinutes;
    });
  }

  Future<void> _saveTotalMinutes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalMinutes', totalMinutes);
  }

  Future<void> _loadGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? goalsString = prefs.getString('fitnessGoals');
    if (goalsString != null) {
      try {
        List<dynamic> goalsJson = jsonDecode(goalsString);
        setState(() {
          fitnessGoals = goalsJson.map((goal) {
            // Ensure each goal is cast to Map<String, dynamic>
            final goalMap = goal as Map<String, dynamic>;
            return <String, dynamic>{
              'goal': goalMap['goal']?.toString() ?? '',
              'progress': double.tryParse(goalMap['progress']?.toString() ?? '0.0') ?? 0.0,
            };
          }).toList();
          print('Goals loaded: $fitnessGoals');
        });
      } catch (e) {
        print('Error loading goals: $e');
      }
    }
  }

  Future<void> _saveGoals() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String goalsString = jsonEncode(fitnessGoals);
      await prefs.setString('fitnessGoals', goalsString);
      print('Goals saved: $goalsString');
    } catch (e) {
      print('Error saving goals: $e');
    }
  }

  void _addGoal() {
    print('Add Goal button pressed with text: ${_goalController.text}');
    if (_goalController.text.trim().isNotEmpty) {
      final newGoal = <String, dynamic>{
        'goal': _goalController.text.trim(),
        'progress': 0.0,
      };
      setState(() {
        fitnessGoals.add(newGoal);
        print('Goal added: $newGoal');
        _goalError = null;
        _goalController.clear();
      });
      _saveGoals();
      _goalFocusNode.unfocus();
      print('Showing SnackBar');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.addGoal ?? 'Goal added successfully',
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      setState(() {
        _goalError = AppLocalizations.of(context)?.goalCannotBeEmpty ?? 'Goal cannot be empty';
        print('Error set: $_goalError');
      });
    }
  }

  void _editGoal(int index) {
    final localizations = AppLocalizations.of(context);
    String editGoalText = localizations?.editGoal ?? 'Edit Goal';
    String goalLabel = localizations?.goal ?? 'Goal';
    String saveText = localizations?.save ?? 'Save';
    _goalController.text = fitnessGoals[index]['goal'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(editGoalText),
          content: TextField(
            controller: _goalController,
            focusNode: _goalFocusNode,
            decoration: InputDecoration(
              labelText: goalLabel,
              errorText: _goalError,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_goalController.text.trim().isEmpty) {
                  setState(() {
                    _goalError = localizations?.goalCannotBeEmpty ?? 'Goal cannot be empty';
                  });
                  return;
                }
                setState(() {
                  fitnessGoals[index]['goal'] = _goalController.text.trim();
                  _goalError = null;
                });
                _saveGoals();
                Navigator.pop(context);
              },
              child: Text(saveText),
            ),
          ],
        );
      },
    );
  }

  void _deleteGoal(int index) {
    final localizations = AppLocalizations.of(context);
    String deleteGoalText = localizations?.deleteGoal ?? 'Delete Goal';
    String confirmText = localizations?.confirmDeleteGoal ?? 'Are you sure you want to delete this goal?';
    String yesText = localizations?.yes ?? 'Yes';
    String noText = localizations?.no ?? 'No';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(deleteGoalText),
          content: Text(confirmText),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  fitnessGoals.removeAt(index);
                });
                _saveGoals();
                Navigator.pop(context);
              },
              child: Text(yesText),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(noText),
            ),
          ],
        );
      },
    );
  }


  void _adjustProgress(int index, double delta) {
    setState(() {
      fitnessGoals[index]['progress'] = (fitnessGoals[index]['progress'] + delta).clamp(0.0, 1.0);
    });
    _saveGoals();
  }

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
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    String workoutsText = localizations?.workouts ?? 'Workouts';
    String minutesText = localizations?.minutes ?? 'Minutes';
    String challengesText = localizations?.challenges ?? 'Challenges';
    String enterGoalText = localizations?.enterYourGoal ?? 'Enter your goal';
    String addGoalText = localizations?.addGoal ?? 'Add Goal';
    String fitnessGoalsText = localizations?.fitnessGoals ?? 'Fitness Goals';
    String favoritesText = localizations?.favorites ?? 'Favorites';
    String noFavoritesText = localizations?.noFavorites ?? 'No favorites added';
    String percentCompleteText = localizations?.percentComplete ?? 'complete';

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildStatContainer(
                      workoutsText, workoutsCompleted.toString(), Colors.green[200]!, Colors.green[800]!),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatContainer(
                      minutesText, totalMinutes.toString(), Colors.blue[200]!, Colors.blue[800]!),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildStatContainer(
                      challengesText, challengesCompleted.toString(), Colors.red[200]!, Colors.red[800]!),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _goalController,
                  focusNode: _goalFocusNode,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)?.enterYourGoal ?? 'Enter your goal',
                    errorText: _goalError,
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.trim().isNotEmpty && _goalError != null) {
                        _goalError = null;
                      }
                    });
                  },
                  onSubmitted: (_) {
                    print('Submitted via keyboard');
                    _addGoal();
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    print('Add Goal button tapped');
                    _addGoal();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)?.addGoal ?? 'Add Goal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _resetFavorites,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Reset Favorites',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              fitnessGoalsText,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
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
                            Expanded(
                              child: Text(
                                fitnessGoals[index]['goal'] as String, // Ensure String type
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
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
                          value: fitnessGoals[index]['progress'] as double, // Ensure double type
                          backgroundColor: Colors.grey[300],
                          color: Colors.deepPurple,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${((fitnessGoals[index]['progress'] as double) * 100).toInt()}% $percentCompleteText",
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
              favoritesText,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            favoriteExercises.isEmpty
                ? Center(
              child: Text(
                noFavoritesText,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : Column(
              children: favoriteExercises.map((exercise) {
                return Card(
                  elevation: 0,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExerciseDetailPage(
                            nameKey: exercise['nameKey']!,
                            stepsKey: exercise['stepsKey']!,
                            imageUrl: exercise['imageUrl']!,
                            bodyPartKey: exercise['bodyPartKey']!,
                            equipmentKey: exercise['equipmentKey']!,
                            difficultyKey: exercise['difficultyKey']!,
                          ),
                        ),
                      );
                      await _loadFavorites();
                    },
                    child: ListTile(
                      leading: Image.asset(
                        exercise['imageUrl']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                      ),
                      title: Text(
                        _getLocalizedValue(context, exercise['nameKey']!),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      subtitle: Text(
                        _getLocalizedValue(context, exercise['bodyPartKey']!),
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