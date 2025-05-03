import 'package:flutter/material.dart';
import 'package:final_2/models/workout.dart';

class WorkoutProvider extends ChangeNotifier {
  final List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  void removeWorkout(int index) {
    _workouts.removeAt(index);
    notifyListeners();
  }

  void clearAllWorkouts() {
    _workouts.clear();
    notifyListeners();
  }
}
