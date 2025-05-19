import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:final_2/generated/l10n.dart';

class CommunityProvider with ChangeNotifier {
  List<Map<String, dynamic>> _posts = [];
  String _searchQuery = '';
  String? _errorMessage;

  List<Map<String, dynamic>> get posts => _posts;
  String get searchQuery => _searchQuery;
  String? get errorMessage => _errorMessage;

  List<Map<String, dynamic>> get filteredPosts => _posts.where((post) {
    return post['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        post['content'].toLowerCase().contains(_searchQuery.toLowerCase());
  }).toList();

  CommunityProvider() {
    _initializePosts();
  }

  Future<void> _initializePosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedPosts = prefs.getString('community_posts');
      if (savedPosts != null) {
        final List<dynamic> decodedPosts = jsonDecode(savedPosts);
        _posts = decodedPosts.map((post) => Map<String, dynamic>.from(post)).toList();
      } else {
        _posts = [
          {
            'title': 'weeklyFitnessChallengeTitle',
            'content': 'weeklyFitnessChallengeContent',
            'author': 'fitnessGuruAuthor',
            'timestamp': '2025-05-18 10:00',
            'likes': 0,
            'likedByUser': false,
          },
          {
            'title': 'plankTipsTitle',
            'content': 'plankTipsContent',
            'author': 'coreMasterAuthor',
            'timestamp': '2025-05-17 15:30',
            'likes': 0,
            'likedByUser': false,
          },
          {
            'title': 'morningStretchRoutineTitle',
            'content': 'morningStretchRoutineContent',
            'author': 'yogaFanAuthor',
            'timestamp': '2025-05-16 08:00',
            'likes': 0,
            'likedByUser': false,
          },
          {
            'title': 'proteinShakeRecipesTitle',
            'content': 'proteinShakeRecipesContent',
            'author': 'nutritionNutAuthor',
            'timestamp': '2025-05-15 12:45',
            'likes': 0,
            'likedByUser': false,
          },
        ];
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'errorLoadPosts: $e';
      notifyListeners();
    }
  }

  Future<void> addPost(String title, String content, String author) async {
    try {
      _posts.insert(0, {
        'title': title,
        'content': content,
        'author': author,
        'timestamp': DateTime.now().toString().substring(0, 16),
        'likes': 0,
        'likedByUser': false,
      });
      await _savePosts();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'errorAddPost: $e';
      notifyListeners();
    }
  }

  Future<void> editPost(int index, String title, String content) async {
    try {
      final post = _posts[index];
      _posts[index] = {
        'title': title,
        'content': content,
        'author': post['author'],
        'timestamp': DateTime.now().toString().substring(0, 16),
        'likes': post['likes'],
        'likedByUser': post['likedByUser'],
      };
      await _savePosts();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'errorEditPost: $e';
      notifyListeners();
    }
  }

  Future<void> deletePost(int index) async {
    try {
      _posts.removeAt(index);
      await _savePosts();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'errorDeletePost: $e';
      notifyListeners();
    }
  }

  Future<void> toggleLike(int index) async {
    try {
      final post = _posts[index];
      post['likedByUser'] = !post['likedByUser'];
      post['likes'] = post['likedByUser'] ? 1 : 0;
      await _savePosts();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'errorToggleLike: $e';
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> _savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('community_posts', jsonEncode(_posts));
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Method to translate posts using AppLocalizations
  List<Map<String, dynamic>> getTranslatedPosts(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return _posts.map((post) {
      return {
        'title': localizationsMap(context, post['title']),
        'content': localizationsMap(context, post['content']),
        'author': localizationsMap(context, post['author']),
        'timestamp': post['timestamp'],
        'likes': post['likes'],
        'likedByUser': post['likedByUser'],
      };
    }).toList();
  }

  // Helper method to map keys to localized strings
  String localizationsMap(BuildContext context, String key) {
    final localizations = AppLocalizations.of(context)!;
    switch (key) {
      case 'weeklyFitnessChallengeTitle':
        return localizations.weeklyFitnessChallengeTitle;
      case 'weeklyFitnessChallengeContent':
        return localizations.weeklyFitnessChallengeContent;
      case 'fitnessGuruAuthor':
        return localizations.fitnessGuruAuthor;
      case 'plankTipsTitle':
        return localizations.plankTipsTitle;
      case 'plankTipsContent':
        return localizations.plankTipsContent;
      case 'coreMasterAuthor':
        return localizations.coreMasterAuthor;
      case 'morningStretchRoutineTitle':
        return localizations.morningStretchRoutineTitle;
      case 'morningStretchRoutineContent':
        return localizations.morningStretchRoutineContent;
      case 'yogaFanAuthor':
        return localizations.yogaFanAuthor;
      case 'proteinShakeRecipesTitle':
        return localizations.proteinShakeRecipesTitle;
      case 'proteinShakeRecipesContent':
        return localizations.proteinShakeRecipesContent;
      case 'nutritionNutAuthor':
        return localizations.nutritionNutAuthor;
      default:
        return key; // Return original string if not a predefined key
    }
  }

  // Method to translate error message
  String? getTranslatedErrorMessage(BuildContext context) {
    if (_errorMessage == null) return null;
    final localizations = AppLocalizations.of(context)!;
    if (_errorMessage!.startsWith('errorLoadPosts:')) {
      final error = _errorMessage!.replaceFirst('errorLoadPosts: ', '');
      return localizations.errorLoadPosts(error);
    } else if (_errorMessage!.startsWith('errorAddPost:')) {
      final error = _errorMessage!.replaceFirst('errorAddPost: ', '');
      return localizations.errorAddPost(error);
    } else if (_errorMessage!.startsWith('errorEditPost:')) {
      final error = _errorMessage!.replaceFirst('errorEditPost: ', '');
      return localizations.errorEditPost(error);
    } else if (_errorMessage!.startsWith('errorDeletePost:')) {
      final error = _errorMessage!.replaceFirst('errorDeletePost: ', '');
      return localizations.errorDeletePost(error);
    } else if (_errorMessage!.startsWith('errorToggleLike:')) {
      final error = _errorMessage!.replaceFirst('errorToggleLike: ', '');
      return localizations.errorToggleLike(error);
    }
    return _errorMessage;
  }
}