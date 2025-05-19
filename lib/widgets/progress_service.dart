import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static Future<void> saveChallengeProgress(String title, double progress) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'challenge_$title';
    print('Saving progress for $key: $progress%'); // Debug log
    await prefs.setDouble(key, progress);
  }

  static Future<double> getChallengeProgress(String title) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'challenge_$title';
    final progress = prefs.getDouble(key) ?? 0.0;
    print('Loaded progress for $key: $progress%'); // Debug log
    return progress;
  }

  static Future<void> resetChallengeProgress(String title) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'challenge_$title';
    print('Resetting progress for $key'); // Debug log
    await prefs.remove(key);
  }

  static Future<int> getWorkoutsCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('workoutsCompleted') ?? 0;
  }

  static Future<int> getChallengesCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('challengesCompleted') ?? 0;
  }

  static Future<int> getTotalMinutes() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('totalMinutes') ?? 0;
  }

  static Future<void> updateWorkoutsCompleted(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('workoutsCompleted', value);
  }

  static Future<void> updateChallengesCompleted(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('challengesCompleted', value);
  }

  static Future<void> updateTotalMinutes(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    final currentMinutes = await getTotalMinutes();
    final newMinutes = currentMinutes + minutes;
    print('Updating totalMinutes: $newMinutes'); // Debug log
    await prefs.setInt('totalMinutes', newMinutes);
  }
}