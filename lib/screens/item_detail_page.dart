import 'package:flutter/material.dart';
import 'package:final_2/screens/exercise_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key});

  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  final List<Map<String, String>> exercises = [
    {
      'name': 'Push-Ups',
      'steps': 'Starting position: Begin by kneeling on an exercise mat or the floor. Place your hands slightly wider than shoulder-width apart, with your fingers facing forward or turned slightly inward. Your feet should be together, with your toes pointed towards your shins. Tighten your core, glutes, and quadriceps muscles to keep your body straight.'
          '\nLower your body: Slowly bend your elbows and lower your chest toward the floor, keeping your body in a straight line from your head to your heels. Avoid letting your back sag or your hips lift. Your elbows should flare outwards as you descend, and you should continue lowering your body until your chest or chin touches the floor.'
          '\nPush upwards: Press through your palms to push your body back up. Ensure your torso remains straight and aligned, with your core and glutes engaged. Focus on pushing the floor away from you as you extend your arms back to the starting position.'
          '\nAlternate hand placement (optional): If you want to target your triceps more, you can reposition your hands so they face forward and keep your elbows close to your body as you lower yourself. This slight change will shift emphasis from your chest muscles to your triceps, while reducing stress on your shoulders.'
          '\nRepeat the movement: Perform the push-up for the desired number of repetitions, maintaining proper form throughout. Control the descent and ascent to avoid injury and maximize the effectiveness of the exercise.',
      'image': 'assets/push-ups.jpeg',
      'bodyPart': 'Chest, Shoulders, Triceps',
      'equipment': 'No equipment',
      'difficulty': 'Intermediate',
    },
    {
      'name': 'Plank',
      'steps': 'Get into position: Begin by lying face down on the floor or mat. Position your elbows directly beneath your shoulders and place your forearms flat on the ground, keeping them shoulder-width apart.'
          '\nForm a straight line: Lift your body off the floor by pressing up onto your toes and forearms. Ensure your body forms a straight line from your head to your heels, keeping your hips neither too high nor sagging down.'
          '\nEngage your core: Tighten your core muscles by pulling your belly button toward your spine. Squeeze your glutes and quadriceps to help maintain stability and keep your body aligned.'
          '\nBreathe and hold: Maintain this position while breathing steadily and focusing on holding the line. Keep your neck neutral by looking down at the floor.'
          '\nFinish the plank: After holding the position for your desired time, slowly lower your knees to the ground and rest. Repeat the process for more sets as needed.',
      'image': 'assets/plank.jpg',
      'bodyPart': 'Core',
      'equipment': 'No equipment',
      'difficulty': 'Beginner',
    },
    {
      'name': 'Squats',
      'steps': 'Set up your stance: Stand with your feet shoulder-width apart, toes slightly turned outward. Keep your chest lifted, shoulders back, and core engaged to maintain balance.'
          '\nInitiate the movement: Push your hips back as though you are sitting down into a chair. Bend your knees, ensuring that they stay aligned with your toes and don’t extend past them. Keep your weight on your heels.'
          '\nLower your body: Continue lowering your body until your thighs are parallel to the ground or deeper if you can maintain good form. Keep your back straight and your chest up.'
          '\nPush back up: Press through your heels to return to the starting position. Straighten your legs while keeping your core engaged, avoiding locking your knees at the top.'
          '\nRepeat the movement: Perform the squat for the desired number of repetitions, maintaining controlled movements throughout to avoid strain.',
      'image': 'assets/leg_workout.jpeg',
      'bodyPart': 'Legs, Glutes',
      'equipment': 'No equipment',
      'difficulty': 'Beginner',
    },
  ];

  // Track favorite status for each exercise
  List<bool> isFavorite = List.generate(3, (_) => false);

  double getDifficultyLevel(String level) {
    switch (level) {
      case 'Beginner':
        return 0.3;
      case 'Intermediate':
        return 0.6;
      case 'Advanced':
        return 0.9;
      default:
        return 0.0;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Set the whole page background color to blueGrey[900]
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Column(
                children: [
                  // Image Section
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      exercise['image']!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Exercise Details Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Exercise Name
                        Center(
                          child: Text(
                            exercise['name']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Body Part
                        Row(
                          children: [
                            Text(
                              'Body Part: ',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              exercise['bodyPart']!,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Equipment
                        Row(
                          children: [
                            Text(
                              'Equipment: ',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              exercise['equipment']!,
                              style: TextStyle(
                                color:  Theme.of(context).textTheme.bodyMedium?.color,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Difficulty
                        Row(
                          children: [
                            Text(
                              'Difficulty: ',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              exercise['difficulty']!,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        // Difficulty Progress Bar
                        Row(
                          children: [
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
                          ],
                        ),
                        SizedBox(height: 16),
                        // Heart Icon
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isFavorite[index] = !isFavorite[index];
                            });

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            List<String> favoriteList = prefs.getStringList('favoriteExercises') ?? [];

                            if (isFavorite[index]) {
                              favoriteList.add(jsonEncode(exercises[index]));
                            } else {
                              favoriteList.removeWhere((item) {
                                Map<String, dynamic> existing = jsonDecode(item);
                                return existing['name'] == exercises[index]['name'];
                              });
                            }

                            await prefs.setStringList('favoriteExercises', favoriteList);
                          },
                          child: Icon(
                            isFavorite[index] ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                        SizedBox(height: 12),
                        // View Details Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
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
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'VIEW DETAILS',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
