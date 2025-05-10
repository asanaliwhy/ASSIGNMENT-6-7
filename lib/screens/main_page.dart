import 'package:flutter/material.dart';
import 'package:final_2/screens/challenge_detail_page.dart';
import 'package:final_2/screens/workout_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_2/map/map_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  int started = 0;
  int completed = 0;
  String searchQuery = '';
  String sortOption = 'title-asc';
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, String>> allChallenges = [
    {'title': 'Full Body Challenge', 'subtitle': 'Complete Body Focus', 'image': 'assets/full_body.jpeg', 'progress': '0'},
    {'title': 'Plank Challenge', 'subtitle': 'Build Core Strength', 'image': 'assets/plank.jpg', 'progress': '0'},
    {'title': 'Fit in 15', 'subtitle': 'Quick Daily Workouts', 'image': 'assets/fit15.jpeg', 'progress': '0'},
    {'title': 'Cardio Blast', 'subtitle': 'Burn Calories Fast', 'image': 'assets/cardio.jpg', 'progress': '0'},
  ];

  final List<Map<String, String>> allGymsNearMe = [
    {'title': 'Gold\'s Gym Venice', 'subtitle': 'The Mecca of Bodybuilding', 'image': 'assets/golden_gym.jpg', 'address': '360 Hampton Dr, Venice', 'latitude': '33.9939', 'longitude': '-118.4698'},
    {'title': 'Planet Fitness', 'subtitle': 'Affordable and local', 'image': 'assets/planet_fitness.jpg', 'address': '456 Fitness Rd, HealthyTown', 'latitude': '40.7565', 'longitude': '-73.9882'},
  ];

  final List<Map<String, String>> allWorkouts = [
    {'title': 'Chest workout', 'duration': '330 minutes', 'image': 'assets/chest_workout.jpeg'},
    {'title': 'Leg workout', 'duration': '330 minutes', 'image': 'assets/leg_workout.jpeg'},
    {'title': 'Plank', 'duration': '330 minutes', 'image': 'assets/plank.jpg'},
    {'title': 'Back workout', 'duration': '330 minutes', 'image': 'assets/back_workout.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    loadProgress();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(begin: Offset(0.5, 0), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Map<String, String>> get challenges {
    var filtered = allChallenges.where((challenge) {
      return challenge['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          challenge['subtitle']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    filtered.sort((a, b) {
      switch (sortOption) {
        case 'title-asc': return a['title']!.compareTo(b['title']!);
        case 'title-desc': return b['title']!.compareTo(a['title']!);
        case 'progress-asc': return double.parse(a['progress']!).compareTo(double.parse(b['progress']!));
        case 'progress-desc': return double.parse(b['progress']!).compareTo(double.parse(a['progress']!));
        default: return 0;
      }
    });
    return filtered;
  }

  List<Map<String, String>> get gymsNearMe {
    var filtered = allGymsNearMe.where((gym) {
      return gym['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          gym['subtitle']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          gym['address']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    filtered.sort((a, b) {
      switch (sortOption) {
        case 'title-asc': return a['title']!.compareTo(b['title']!);
        case 'title-desc': return b['title']!.compareTo(a['title']!);
        default: return 0;
      }
    });
    return filtered;
  }

  List<Map<String, String>> get workouts {
    var filtered = allWorkouts.where((workout) {
      return workout['title']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          workout['duration']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    filtered.sort((a, b) {
      switch (sortOption) {
        case 'title-asc': return a['title']!.compareTo(b['title']!);
        case 'title-desc': return b['title']!.compareTo(a['title']!);
        case 'duration-asc': return a['duration']!.compareTo(b['duration']!);
        case 'duration-desc': return b['duration']!.compareTo(a['duration']!);
        default: return 0;
      }
    });
    return filtered;
  }

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < allChallenges.length; i++) {
      final title = allChallenges[i]['title']!;
      final progress = prefs.getDouble('challenge_$title') ?? 0.0;
      print('Loading progress for $title: $progress%'); // Debug log
      setState(() {
        allChallenges[i]['progress'] = progress.toStringAsFixed(0);
      });
    }
    setState(() {
      started = prefs.getInt('started_workouts') ?? 0;
      completed = prefs.getInt('completed_workouts') ?? 0;
    });
  }

  void saveProgress(String title, double newProgress) async {
    final prefs = await SharedPreferences.getInstance();
    print('Saving progress for $title: $newProgress%'); // Debug log
    final index = allChallenges.indexWhere((challenge) => challenge['title'] == title);
    if (index != -1) {
      setState(() {
        allChallenges[index]['progress'] = newProgress.toStringAsFixed(0);
      });
      await prefs.setDouble('challenge_$title', newProgress);
      // Update started and completed counts
      setState(() {
        started = getStartedWorkouts();
        completed = getStartedWorkouts();
      });
      await prefs.setInt('started_workouts', started);
      await prefs.setInt('completed_workouts', completed);
    } else {
      print('Error: Challenge $title not found in allChallenges');
    }
  }

  int getCompletedWorkouts() => allChallenges.where((c) => double.parse(c['progress']!) == 100).length;
  int getStartedWorkouts() => allChallenges.where((c) => double.parse(c['progress']!) > 0).length;

  void updateTotalMinutes(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    int totalMinutes = prefs.getInt('totalMinutes') ?? 0;
    totalMinutes += minutes;
    await prefs.setInt('totalMinutes', totalMinutes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Colors.green[200], borderRadius: BorderRadius.circular(8)),
              child: Text('$started Started', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green[800])),
            ),
            SizedBox(width: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Colors.blue[200], borderRadius: BorderRadius.circular(8)),
              child: Text('$completed Completed', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[800])),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Search', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
                    onChanged: (value) => setState(() => searchQuery = value),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: sortOption,
                    decoration: InputDecoration(labelText: 'Sort by', border: OutlineInputBorder()),
                    items: [
                      DropdownMenuItem(value: 'title-asc', child: Text('Title (A-Z)')),
                      DropdownMenuItem(value: 'title-desc', child: Text('Title (Z-A)')),
                      DropdownMenuItem(value: 'progress-asc', child: Text('Progress (Low to High)')),
                      DropdownMenuItem(value: 'progress-desc', child: Text('Progress (High to Low)')),
                      DropdownMenuItem(value: 'duration-asc', child: Text('Duration (Short to Long)')),
                      DropdownMenuItem(value: 'duration-desc', child: Text('Duration (Long to Short)')),
                    ],
                    onChanged: (value) {
                      if (value != null) setState(() => sortOption = value);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text("Challenges", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: challenges.length,
                      itemBuilder: (context, index) {
                        final challenge = challenges[index];
                        return AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _fadeAnimation.value,
                              child: Transform.translate(
                                offset: _slideAnimation.value,
                                child: child,
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => ChallengeDetailPage(
                                  title: challenge['title']!,
                                  onProgressUpdate: (newProgress) => saveProgress(challenge['title']!, newProgress),
                                  onMinutesUpdate: updateTotalMinutes,
                                ),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  final tween = Tween(begin: begin, end: end);
                                  final offsetAnimation = animation.drive(tween.chain(CurveTween(curve: Curves.easeInOut)));
                                  return SlideTransition(position: offsetAnimation, child: child);
                                },
                              ),
                            ).then((_) => loadProgress()), // Refresh progress on return
                            child: Container(
                              width: 250,
                              margin: EdgeInsets.only(right: 16),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                                          Text(challenge['subtitle']!, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium?.color)),
                                          const SizedBox(height: 8),
                                          LinearProgressIndicator(
                                            value: double.parse(challenge['progress']!) / 100,
                                            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                          Text('${challenge['progress']}% Completed', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium?.color)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text("Gyms Near Me", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: gymsNearMe.length,
                      itemBuilder: (context, index) {
                        final gym = gymsNearMe[index];
                        return AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _fadeAnimation.value,
                              child: Transform.translate(
                                offset: _slideAnimation.value,
                                child: child,
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MapPage(gymsNearMe: [gymsNearMe[index]]))),
                            child: Container(
                              width: 250,
                              margin: EdgeInsets.only(right: 16),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                                          Text(gym['title']!, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium?.color)),
                                          const SizedBox(height: 8),
                                          Text(gym['address']!, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text("Workout Plans", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  const SizedBox(height: 16),
                  ListView.builder(
                    itemCount: workouts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Transform.translate(
                              offset: _slideAnimation.value,
                              child: child,
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => WorkoutDetailPage(
                                title: workout['title']!,
                                onProgressUpdate: (progress) async {
                                  final prefs = await SharedPreferences.getInstance();
                                  if (progress == 100) {
                                    final completed = prefs.getInt('completed_workouts') ?? 0;
                                    await prefs.setInt('completed_workouts', completed + 1);
                                    setState(() {
                                      this.completed = completed + 1;
                                    });
                                  }
                                },
                              ),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                final tween = Tween(begin: begin, end: end);
                                final offsetAnimation = animation.drive(tween.chain(CurveTween(curve: Curves.easeInOut)));
                                return SlideTransition(position: offsetAnimation, child: child);
                              },
                            ),
                          ).then((_) => loadProgress()), // Refresh progress on return
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}