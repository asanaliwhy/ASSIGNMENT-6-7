import 'package:flutter/material.dart';
import 'package:final_2/screens/exercise_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> with TickerProviderStateMixin {
  final List<Map<String, String>> exercises = [
    {
      'name': 'Push-Ups',
      'steps': 'Starting position: Begin by kneeling on an exercise mat or the floor...',
      'image': 'assets/push-ups.jpeg',
      'bodyPart': 'Chest, Shoulders, Triceps',
      'equipment': 'No equipment',
      'difficulty': 'Intermediate',
    },
    {
      'name': 'Plank',
      'steps': 'Get into position: Begin by lying face down on the floor or mat...',
      'image': 'assets/plank.jpg',
      'bodyPart': 'Core',
      'equipment': 'No equipment',
      'difficulty': 'Beginner',
    },
    {
      'name': 'Squats',
      'steps': 'Set up your stance: Stand with your feet shoulder-width apart...',
      'image': 'assets/leg_workout.jpeg',
      'bodyPart': 'Legs, Glutes',
      'equipment': 'No equipment',
      'difficulty': 'Beginner',
    },
  ];

  List<bool> isFavorite = List.generate(3, (_) => false);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  double getDifficultyLevel(String level) {
    switch (level) {
      case 'Beginner': return 0.3;
      case 'Intermediate': return 0.6;
      case 'Advanced': return 0.9;
      default: return 0.0;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteList = prefs.getStringList('favoriteExercises') ?? [];
    setState(() {
      for (int i = 0; i < exercises.length; i++) {
        isFavorite[i] = favoriteList.any((item) {
          final decoded = jsonDecode(item);
          return decoded['name'] == exercises[i]['name'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                color: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(exercise['image']!, height: 180, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Text(exercise['name']!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple))),
                          SizedBox(height: 10),
                          Row(children: [
                            Text('Body Part: ', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 14, fontWeight: FontWeight.w600)),
                            Text(exercise['bodyPart']!, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14)),
                          ]),
                          SizedBox(height: 8),
                          Row(children: [
                            Text('Equipment: ', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 14, fontWeight: FontWeight.w600)),
                            Text(exercise['equipment']!, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14)),
                          ]),
                          SizedBox(height: 8),
                          Row(children: [
                            Text('Difficulty: ', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 14, fontWeight: FontWeight.w600)),
                            Text(exercise['difficulty']!, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14)),
                          ]),
                          SizedBox(height: 12),
                          Row(children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: getDifficultyLevel(exercise['difficulty']!),
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                                minHeight: 6,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.fitness_center, color: Colors.deepPurple),
                          ]),
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () async {
                              setState(() => isFavorite[index] = !isFavorite[index]);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              List<String> favoriteList = prefs.getStringList('favoriteExercises') ?? [];
                              if (isFavorite[index]) {
                                if (!favoriteList.any((item) => jsonDecode(item)['name'] == exercises[index]['name'])) {
                                  favoriteList.add(jsonEncode(exercises[index]));
                                }
                              } else {
                                favoriteList.removeWhere((item) => jsonDecode(item)['name'] == exercises[index]['name']);
                              }
                              await prefs.setStringList('favoriteExercises', favoriteList);
                            },
                            child: Icon(isFavorite[index] ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 30),
                          ),
                          SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => ExerciseDetailPage(
                                    name: exercise['name']!,
                                    steps: exercise['steps']!,
                                    imageUrl: exercise['image']!,
                                    bodyPart: exercise['bodyPart']!,
                                    equipment: exercise['equipment']!,
                                    difficulty: exercise['difficulty']!,
                                  ),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return FadeTransition(opacity: animation, child: child);
                                  },
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text('VIEW DETAILS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
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
    );
  }
}