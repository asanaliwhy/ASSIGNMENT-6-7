import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_2/generated/l10n.dart';
import 'dart:convert';

class ExerciseDetailPage extends StatefulWidget {
  final String nameKey;
  final String stepsKey;
  final String imageUrl;
  final String bodyPartKey;
  final String equipmentKey;
  final String difficultyKey;

  const ExerciseDetailPage({
    required this.nameKey,
    required this.stepsKey,
    required this.imageUrl,
    required this.bodyPartKey,
    required this.equipmentKey,
    required this.difficultyKey,
    super.key,
  });

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteList = prefs.getStringList('favoriteExercises') ?? [];
    setState(() {
      isFavorite = favoriteList.any((item) {
        final decoded = jsonDecode(item);
        return decoded['nameKey'] == widget.nameKey;
      });
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteList = prefs.getStringList('favoriteExercises') ?? [];
    Map<String, String> exercise = {
      'nameKey': widget.nameKey,
      'stepsKey': widget.stepsKey,
      'imageUrl': widget.imageUrl,
      'bodyPartKey': widget.bodyPartKey,
      'equipmentKey': widget.equipmentKey,
      'difficultyKey': widget.difficultyKey,
    };
    setState(() {
      isFavorite = !isFavorite;
    });
    if (isFavorite) {
      if (!favoriteList.any((item) => jsonDecode(item)['nameKey'] == widget.nameKey)) {
        favoriteList.add(jsonEncode(exercise));
      }
    } else {
      favoriteList.removeWhere((item) => jsonDecode(item)['nameKey'] == widget.nameKey);
    }
    await prefs.setStringList('favoriteExercises', favoriteList);
  }

  double getDifficultyLevel(String difficultyKey, AppLocalizations localizations) {
    switch (difficultyKey) {
      case 'beginner':
        return 0.2;
      case 'intermediate':
        return 0.5;
      case 'advanced':
        return 0.8;
      default:
        return 0.0;
    }
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
                    color: Colors.white70,
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

  String _getLocalizedValue(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;
    final Map<String, String> keyMap = {
      'pushUpsName': localizations.pushUpsName,
      'squatsName': localizations.squatsName,
      'plankName': localizations.plankName,
      'jumpingJacksName': localizations.jumpingJacksName,
      'pushUpsSteps': localizations.pushUpsSteps,
      'squatsSteps': localizations.squatsSteps,
      'bodyPartChest': localizations.bodyPartChest,
      'bodyPartLegs': localizations.bodyPartLegs,
      'equipmentNone': localizations.equipmentNone,
      'equipmentMat': localizations.equipmentMat,
      'beginner': localizations.beginner,
      'intermediate': localizations.intermediate,
      'advanced': localizations.advanced,
    };
    return keyMap[key] ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final stepsList = _getLocalizedValue(context, widget.stepsKey).split('\n');

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          _getLocalizedValue(context, widget.nameKey),
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 24),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          widget.imageUrl,
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 220,
                            color: Colors.grey,
                            child: const Center(child: Text('Image not found')),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          _getLocalizedValue(context, widget.nameKey),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoItem(
                        localizations.bodyPart,
                        _getLocalizedValue(context, widget.bodyPartKey),
                        Colors.redAccent,
                        Icons.fitness_center,
                      ),
                      _buildInfoItem(
                        localizations.equipment,
                        _getLocalizedValue(context, widget.equipmentKey),
                        Colors.cyanAccent,
                        Icons.electrical_services,
                      ),
                      _buildInfoItem(
                        localizations.difficulty,
                        _getLocalizedValue(context, widget.difficultyKey),
                        Colors.pinkAccent,
                        Icons.star,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: getDifficultyLevel(widget.difficultyKey, localizations),
                              backgroundColor: Colors.grey[700],
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.fitness_center, color: Colors.white),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: _toggleFavorite,
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    localizations.steps,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: stepsList.asMap().entries.map((entry) {
                      int index = entry.key + 1;
                      String step = entry.value.trim();
                      if (step.isEmpty) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.deepPurple.withOpacity(0.4),
                                Colors.deepPurpleAccent.withOpacity(0.4),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 16,
                                child: Text(
                                  '$index',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  step,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    height: 1.4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}