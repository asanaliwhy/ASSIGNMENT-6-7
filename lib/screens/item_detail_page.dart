import 'package:flutter/material.dart';
import 'package:final_2/screens/exercise_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:final_2/generated/l10n.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> with TickerProviderStateMixin {
  final List<Map<String, String>> exercises = [
    {
      'nameKey': 'pushUpsName',
      'stepsKey': 'pushUpsSteps',
      'image': 'assets/push-ups.jpeg',
      'bodyPartKey': 'bodyPartChest', // Changed to match ExerciseDetailPage
      'equipmentKey': 'equipmentNone',
      'difficultyKey': 'intermediate',
    },
    {
      'nameKey': 'plankName',
      'stepsKey': 'plankSteps',
      'image': 'assets/plank.jpg',
      'bodyPartKey': 'bodyPartCore', // Kept as is, assuming AppLocalizations supports it
      'equipmentKey': 'equipmentNone',
      'difficultyKey': 'beginner',
    },
    {
      'nameKey': 'squatsName',
      'stepsKey': 'squatsSteps',
      'image': 'assets/leg_workout.jpeg',
      'bodyPartKey': 'bodyPartLegs', // Changed to match ExerciseDetailPage
      'equipmentKey': 'equipmentNone',
      'difficultyKey': 'beginner',
    },
  ];

  List<bool> isFavorite = List.generate(3, (_) => false);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  double getDifficultyLevel(String difficultyKey) {
    switch (difficultyKey) {
      case 'beginner':
        return 0.3;
      case 'intermediate':
        return 0.6;
      case 'advanced':
        return 0.9;
      default:
        return 0.0;
    }
  }

  String _getLocalizedValue(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;
    final Map<String, String> keyMap = {
      // Exercise names
      'pushUpsName': localizations.pushUpsName,
      'plankName': localizations.plankName,
      'squatsName': localizations.squatsName,
      // Body parts
      'bodyPartChest': localizations.bodyPartChest,
      'bodyPartCore': localizations.bodyPartCore,
      'bodyPartLegs': localizations.bodyPartLegs,
      // Equipment
      'equipmentNone': localizations.equipmentNone,
      // Difficulty
      'beginner': localizations.beginner,
      'intermediate': localizations.intermediate,
      'advanced': localizations.advanced,
    };
    return keyMap[key] ?? 'Unknown'; // Fallback to 'Unknown' if not found
  }

  Widget _buildInfoItem(String title, String value, Color titleColor, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: titleColor, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.black54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
          return decoded['nameKey'] == exercises[i]['nameKey'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
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
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              _getLocalizedValue(context, exercise['nameKey']!),
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoItem(
                            localizations.bodyPartLabel,
                            _getLocalizedValue(context, exercise['bodyPartKey']!),
                            Colors.redAccent,
                            Icons.fitness_center,
                          ),
                          _buildInfoItem(
                            localizations.equipmentLabel,
                            _getLocalizedValue(context, exercise['equipmentKey']!),
                            Colors.cyan,
                            Icons.electrical_services,
                          ),
                          _buildInfoItem(
                            localizations.difficultyLabel,
                            _getLocalizedValue(context, exercise['difficultyKey']!),
                            Colors.pinkAccent,
                            Icons.star,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 110,
                                child: LinearProgressIndicator(
                                  value: getDifficultyLevel(exercise['difficultyKey']!),
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                                  minHeight: 6,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.fitness_center, color: Colors.deepPurple),
                            ],
                          ),
                          const SizedBox(height: 16),
                          GestureDetector(
                            onTap: () async {
                              setState(() => isFavorite[index] = !isFavorite[index]);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              List<String> favoriteList = prefs.getStringList('favoriteExercises') ?? [];
                              if (isFavorite[index]) {
                                if (!favoriteList.any((item) => jsonDecode(item)['nameKey'] == exercises[index]['nameKey'])) {
                                  favoriteList.add(jsonEncode(exercises[index]));
                                }
                              } else {
                                favoriteList.removeWhere((item) => jsonDecode(item)['nameKey'] == exercises[index]['nameKey']);
                              }
                              await prefs.setStringList('favoriteExercises', favoriteList);
                            },
                            child: Icon(isFavorite[index] ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 30),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => ExerciseDetailPage(
                                    nameKey: exercise['nameKey']!,
                                    stepsKey: exercise['stepsKey']!,
                                    imageUrl: exercise['image']!,
                                    bodyPartKey: exercise['bodyPartKey']!,
                                    equipmentKey: exercise['equipmentKey']!,
                                    difficultyKey: exercise['difficultyKey']!,
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
                              child: Text(localizations.viewDetails, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
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