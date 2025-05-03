import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:final_2/models/workout.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('workouts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Создание таблицы с полем goal
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE workouts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        duration TEXT NOT NULL,
        calories_burned TEXT NOT NULL,
        goal TEXT NOT NULL
      )
    ''');
  }

  // Добавление новой тренировки
  Future<int> addWorkout(Workout workout) async {
    final db = await instance.database;
    return await db.insert('workouts', workout.toJson());
  }

  // Получение всех тренировок
  Future<List<Workout>> getWorkouts() async {
    final db = await instance.database;
    final result = await db.query('workouts');
    return result.map((e) => Workout.fromJson(e)).toList();
  }

  // Удаление тренировки по ID
  Future<int> deleteWorkout(int id) async {
    final db = await instance.database;
    return await db.delete('workouts', where: 'id = ?', whereArgs: [id]);
  }
}
