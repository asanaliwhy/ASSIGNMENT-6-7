import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatelessWidget {
  final String name;
  final String steps;
  final String imageUrl;
  final String bodyPart;
  final String equipment;
  final String difficulty;

  const ExerciseDetailPage({
    required this.name,
    required this.steps,
    required this.imageUrl,
    required this.bodyPart,
    required this.equipment,
    required this.difficulty,
    super.key,
  });

  double getDifficultyLevel(String difficulty) {
    if (difficulty == "Beginner") {
      return 0.2;
    } else if (difficulty == "Intermediate") {
      return 0.5;
    } else if (difficulty == "Advanced") {
      return 0.8;
    }
    return 0.0;
  }

  // Helper method to create info items (like body part, equipment, etc.)
  Widget _buildInfoItem(String title, String value, Color titleColor,
      IconData icon) {
    return Row(
      children: [
        Icon(icon, color: titleColor, size: 24),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: titleColor),
            ),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 14, fontFamily: 'Poppins', color: Colors.white70),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final stepsList = steps.split('\n');

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
            name, style: const TextStyle(fontFamily: 'Poppins', fontSize: 24)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            // Prevent content cutoff at bottom
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image and Info Card
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          imageUrl,
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildInfoItem('Body Part', bodyPart, Colors.redAccent,
                          Icons.fitness_center),
                      const SizedBox(height: 8),
                      _buildInfoItem('Equipment', equipment, Colors.cyanAccent,
                          Icons.electrical_services),
                      const SizedBox(height: 8),
                      _buildInfoItem(
                          'Difficulty', difficulty, Colors.pinkAccent,
                          Icons.star),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: getDifficultyLevel(difficulty),
                              backgroundColor: Colors.grey[700],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.redAccent),
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.fitness_center, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Steps:',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Step List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: stepsList
                        .asMap()
                        .entries
                        .map((entry) {
                      int index = entry.key + 1;
                      String step = entry.value.trim();
                      if (step.isEmpty) return SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.deepPurple.withOpacity(0.6),
                                Colors.deepPurpleAccent.withOpacity(0.6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text(
                                  '$index',
                                  style: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
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
                                    height: 1.6,
                                    fontWeight: FontWeight.w500,
                                  ),
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