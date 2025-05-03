class Workout {
  final String name;
  final String duration;
  final String caloriesBurned;
  final String goal;  // Новое поле для цели

  Workout({
    required this.name,
    required this.duration,
    required this.caloriesBurned,
    required this.goal,  // Добавляем в конструктор
  });

  // Преобразование из JSON в объект
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      name: json['name'],
      duration: json['duration'],
      caloriesBurned: json['calories_burned'],
      goal: json['goal'],  // Добавляем обработку поля goal
    );
  }

  // Преобразование объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'duration': duration,
      'calories_burned': caloriesBurned,
      'goal': goal,  // Добавляем поле goal в JSON
    };
  }
}
