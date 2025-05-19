import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/progress_service.dart';
import 'package:final_2/generated/l10n.dart';

class MainProvider with ChangeNotifier {
  int _started = 0;
  int _completed = 0;
  int _totalMinutes = 0;
  String _searchQuery = '';
  String _sortOption = 'title-asc';
  String? _errorMessage;

  final List<Map<String, String>> _allChallenges = [
    {'title': 'fullBodyChallengeTitle', 'subtitle': 'fullBodyChallengeSubtitle', 'image': 'assets/full_body.jpeg', 'progress': '0'},
    {'title': 'plankChallengeTitle', 'subtitle': 'plankChallengeSubtitle', 'image': 'assets/plank.jpg', 'progress': '0'},
    {'title': 'fitIn15Title', 'subtitle': 'fitIn15Subtitle', 'image': 'assets/fit15.jpeg', 'progress': '0'},
    {'title': 'cardioBlastTitle', 'subtitle': 'cardioBlastSubtitle', 'image': 'assets/cardio.jpg', 'progress': '0'},
  ];

  final List<Map<String, String>> _allGymsNearMe = [
    {
      'title': 'goldsGymVeniceTitle',
      'subtitle': 'goldsGymVeniceSubtitle',
      'image': 'assets/golden_gym.jpg',
      'address': 'goldsGymVeniceAddress',
      'latitude': '33.9939',
      'longitude': '-118.4698'
    },
    {
      'title': 'planetFitnessTitle',
      'subtitle': 'planetFitnessSubtitle',
      'image': 'assets/planet_fitness.jpg',
      'address': 'planetFitnessAddress',
      'latitude': '40.7565',
      'longitude': '-73.9882'
    },
  ];

  final List<Map<String, String>> _allWorkouts = [
    {'title': 'chestWorkoutTitle', 'duration': 'chestWorkoutDuration', 'image': 'assets/chest_workout.jpeg', 'progress': '0'},
    {'title': 'legWorkoutTitle', 'duration': 'legWorkoutDuration', 'image': 'assets/leg_workout.jpeg', 'progress': '0'},
    {'title': 'plankWorkoutTitle', 'duration': 'plankWorkoutDuration', 'image': 'assets/plank.jpg', 'progress': '0'},
    {'title': 'backWorkoutTitle', 'duration': 'backWorkoutDuration', 'image': 'assets/back_workout.jpg', 'progress': '0'},
  ];

  int get started => _started;
  int get completed => _completed;
  int get totalMinutes => _totalMinutes;
  String get searchQuery => _searchQuery;
  String get sortOption => _sortOption;
  String? get errorMessage => _errorMessage;

  // Modified getters to use translated data
  List<Map<String, String>> allChallenges(BuildContext context) => getTranslatedChallenges(context);
  List<Map<String, String>> allWorkouts(BuildContext context) => getTranslatedWorkouts(context);
  List<Map<String, String>> get allGymsNearMe => _allGymsNearMe; // Not used in ProgressPage

  List<Map<String, String>> get challenges {
    var filtered = List<Map<String, String>>.from(getTranslatedChallenges(null));
    filtered.retainWhere((challenge) {
      return challenge['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          challenge['subtitle']!.toLowerCase().contains(_searchQuery.toLowerCase());
    });
    filtered.sort((a, b) {
      switch (_sortOption) {
        case 'title-asc':
          return a['title']!.compareTo(b['title']!);
        case 'title-desc':
          return b['title']!.compareTo(a['title']!);
        case 'progress-asc':
          return double.parse(a['progress']!).compareTo(double.parse(b['progress']!));
        case 'progress-desc':
          return double.parse(b['progress']!).compareTo(double.parse(a['progress']!));
        default:
          return 0;
      }
    });
    return filtered;
  }

  List<Map<String, String>> get gymsNearMe {
    var filtered = List<Map<String, String>>.from(getTranslatedGymsNearMe(null));
    filtered.retainWhere((gym) {
      return gym['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          gym['subtitle']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          gym['address']!.toLowerCase().contains(_searchQuery.toLowerCase());
    });
    filtered.sort((a, b) {
      switch (_sortOption) {
        case 'title-asc':
          return a['title']!.compareTo(b['title']!);
        case 'title-desc':
          return b['title']!.compareTo(a['title']!);
        default:
          return 0;
      }
    });
    return filtered;
  }

  List<Map<String, String>> get workouts {
    var filtered = List<Map<String, String>>.from(getTranslatedWorkouts(null));
    filtered.retainWhere((workout) {
      return workout['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          workout['duration']!.toLowerCase().contains(_searchQuery.toLowerCase());
    });
    filtered.sort((a, b) {
      switch (_sortOption) {
        case 'title-asc':
          return a['title']!.compareTo(b['title']!);
        case 'title-desc':
          return b['title']!.compareTo(a['title']!);
        case 'duration-asc':
          return a['duration']!.compareTo(b['duration']!);
        case 'duration-desc':
          return b['duration']!.compareTo(a['duration']!);
        case 'progress-asc':
          return double.parse(a['progress']!).compareTo(double.parse(b['progress']!));
        case 'progress-desc':
          return double.parse(b['progress']!).compareTo(double.parse(a['progress']!));
        default:
          return 0;
      }
    });
    return filtered;
  }

  MainProvider() {
    loadProgress();
  }

  Future<void> loadProgress() async {
    try {
      // Load challenge progress
      for (int i = 0; i < _allChallenges.length; i++) {
        final title = _allChallenges[i]['title']!;
        final progress = await ProgressService.getChallengeProgress(title);
        _allChallenges[i]['progress'] = progress.toStringAsFixed(0);
      }
      // Load workout progress
      for (int i = 0; i < _allWorkouts.length; i++) {
        final title = _allWorkouts[i]['title']!;
        final progress = await ProgressService.getChallengeProgress(title);
        _allWorkouts[i]['progress'] = progress.toStringAsFixed(0);
      }
      // Load total minutes
      _totalMinutes = await ProgressService.getTotalMinutes();
      _updateCounts();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'errorLoadProgress: $e';
      notifyListeners();
    }
  }

  Future<void> saveProgress(String title, double newProgress) async {
    try {
      await ProgressService.saveChallengeProgress(title, newProgress);
      final index = _allChallenges.indexWhere((challenge) => challenge['title'] == title);
      if (index != -1) {
        _allChallenges[index]['progress'] = newProgress.toStringAsFixed(0);
        _updateCounts();
        await ProgressService.updateWorkoutsCompleted(_completed);
        await ProgressService.updateChallengesCompleted(_completed);
        _errorMessage = null;
        notifyListeners();
      } else {
        throw Exception('errorChallengeNotFound: $title');
      }
    } catch (e) {
      _errorMessage = 'errorSaveChallengeProgress: $e';
      notifyListeners();
    }
  }

  Future<void> saveWorkoutProgress(String title, double newProgress) async {
    try {
      await ProgressService.saveChallengeProgress(title, newProgress);
      final index = _allWorkouts.indexWhere((workout) => workout['title'] == title);
      if (index != -1) {
        _allWorkouts[index]['progress'] = newProgress.toStringAsFixed(0);
        _updateCounts();
        await ProgressService.updateWorkoutsCompleted(_completed);
        _errorMessage = null;
        notifyListeners();
      } else {
        throw Exception('errorWorkoutNotFound: $title');
      }
    } catch (e) {
      _errorMessage = 'errorSaveWorkoutProgress: $e';
      notifyListeners();
    }
  }

  Future<void> resetProgress(String title, bool isChallenge) async {
    try {
      print('Resetting progress for title: $title, isChallenge: $isChallenge'); // Debug log
      await ProgressService.resetChallengeProgress(title);
      if (isChallenge) {
        final index = _allChallenges.indexWhere((challenge) => challenge['title'] == title);
        if (index != -1) {
          _allChallenges[index]['progress'] = '0';
        } else {
          throw Exception('errorChallengeNotFound: $title');
        }
      } else {
        final index = _allWorkouts.indexWhere((workout) => workout['title'] == title);
        if (index != -1) {
          _allWorkouts[index]['progress'] = '0';
        } else {
          throw Exception('errorWorkoutNotFound: $title');
        }
      }
      _updateCounts();
      await ProgressService.updateWorkoutsCompleted(_completed);
      await ProgressService.updateChallengesCompleted(_completed);
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      print('Error resetting progress: $e'); // Debug log
      _errorMessage = 'errorResetProgress: $e';
      notifyListeners();
    }
  }

  Future<void> updateTotalMinutes(int minutes) async {
    try {
      await ProgressService.updateTotalMinutes(minutes);
      _totalMinutes = await ProgressService.getTotalMinutes();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'errorUpdateTotalMinutes: $e';
      notifyListeners();
    }
  }

  void _updateCounts() {
    _started = _allChallenges.where((c) => double.parse(c['progress']!) > 0).length +
        _allWorkouts.where((w) => double.parse(w['progress']!) > 0).length;
    _completed = _allChallenges.where((c) => double.parse(c['progress']!) == 100).length +
        _allWorkouts.where((w) => double.parse(w['progress']!) == 100).length;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSortOption(String option) {
    _sortOption = option;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Translation methods
  List<Map<String, String>> getTranslatedChallenges(BuildContext? context) {
    final localizations = context != null ? AppLocalizations.of(context)! : null;
    return _allChallenges.map((challenge) {
      return {
        'key': challenge['title']!, // Added key field
        'title': localizationsMap(context, challenge['title']!),
        'subtitle': localizationsMap(context, challenge['subtitle']!),
        'image': challenge['image']!,
        'progress': challenge['progress']!,
      };
    }).toList();
  }

  List<Map<String, String>> getTranslatedGymsNearMe(BuildContext? context) {
    final localizations = context != null ? AppLocalizations.of(context)! : null;
    return _allGymsNearMe.map((gym) {
      return {
        'title': localizationsMap(context, gym['title']!),
        'subtitle': localizationsMap(context, gym['subtitle']!),
        'image': gym['image']!,
        'address': localizationsMap(context, gym['address']!),
        'latitude': gym['latitude']!,
        'longitude': gym['longitude']!,
      };
    }).toList();
  }

  List<Map<String, String>> getTranslatedWorkouts(BuildContext? context) {
    final localizations = context != null ? AppLocalizations.of(context)! : null;
    return _allWorkouts.map((workout) {
      return {
        'key': workout['title']!, // Added key field
        'title': localizationsMap(context, workout['title']!),
        'duration': localizationsMap(context, workout['duration']!),
        'image': workout['image']!,
        'progress': workout['progress']!,
      };
    }).toList();
  }

  String? getTranslatedErrorMessage(BuildContext context) {
    if (_errorMessage == null) return null;
    final localizations = AppLocalizations.of(context)!;
    if (_errorMessage!.startsWith('errorLoadProgress:')) {
      final error = _errorMessage!.replaceFirst('errorLoadProgress: ', '');
      return localizations.errorLoadProgress(error);
    } else if (_errorMessage!.startsWith('errorSaveChallengeProgress:')) {
      final error = _errorMessage!.replaceFirst('errorSaveChallengeProgress: ', '');
      return localizations.errorSaveChallengeProgress(error);
    } else if (_errorMessage!.startsWith('errorSaveWorkoutProgress:')) {
      final error = _errorMessage!.replaceFirst('errorSaveWorkoutProgress: ', '');
      return localizations.errorSaveWorkoutProgress(error);
    } else if (_errorMessage!.startsWith('errorResetProgress:')) {
      final error = _errorMessage!.replaceFirst('errorResetProgress: ', '');
      return localizations.errorResetProgress(error);
    } else if (_errorMessage!.startsWith('errorUpdateTotalMinutes:')) {
      final error = _errorMessage!.replaceFirst('errorUpdateTotalMinutes: ', '');
      return localizations.errorUpdateTotalMinutes(error);
    } else if (_errorMessage!.startsWith('errorChallengeNotFound:')) {
      final title = _errorMessage!.replaceFirst('errorChallengeNotFound: ', '');
      return localizations.errorChallengeNotFound(title);
    } else if (_errorMessage!.startsWith('errorWorkoutNotFound:')) {
      final title = _errorMessage!.replaceFirst('errorWorkoutNotFound: ', '');
      return localizations.errorWorkoutNotFound(title);
    }
    return _errorMessage;
  }

  String localizationsMap(BuildContext? context, String key) {
    if (context == null) return key;
    final localizations = AppLocalizations.of(context)!;
    switch (key) {
    // Challenges
      case 'fullBodyChallengeTitle':
        return localizations.fullBodyChallengeTitle;
      case 'fullBodyChallengeSubtitle':
        return localizations.fullBodyChallengeSubtitle;
      case 'plankChallengeTitle':
        return localizations.plankChallengeTitle;
      case 'plankChallengeSubtitle':
        return localizations.plankChallengeSubtitle;
      case 'fitIn15Title':
        return localizations.fitIn15Title;
      case 'fitIn15Subtitle':
        return localizations.fitIn15Subtitle;
      case 'cardioBlastTitle':
        return localizations.cardioBlastTitle;
      case 'cardioBlastSubtitle':
        return localizations.cardioBlastSubtitle;
    // Gyms
      case 'goldsGymVeniceTitle':
        return localizations.goldsGymVeniceTitle;
      case 'goldsGymVeniceSubtitle':
        return localizations.goldsGymVeniceSubtitle;
      case 'goldsGymVeniceAddress':
        return localizations.goldsGymVeniceAddress;
      case 'planetFitnessTitle':
        return localizations.planetFitnessTitle;
      case 'planetFitnessSubtitle':
        return localizations.planetFitnessSubtitle;
      case 'planetFitnessAddress':
        return localizations.planetFitnessAddress;
    // Workouts
      case 'chestWorkoutTitle':
        return localizations.chestWorkoutTitle;
      case 'chestWorkoutDuration':
        return localizations.chestWorkoutDuration;
      case 'legWorkoutTitle':
        return localizations.legWorkoutTitle;
      case 'legWorkoutDuration':
        return localizations.legWorkoutDuration;
      case 'plankWorkoutTitle':
        return localizations.plankWorkoutTitle;
      case 'plankWorkoutDuration':
        return localizations.plankWorkoutDuration;
      case 'backWorkoutTitle':
        return localizations.backWorkoutTitle;
      case 'backWorkoutDuration':
        return localizations.backWorkoutDuration;
      default:
        return key;
    }
  }
}