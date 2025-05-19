import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_2/generated/l10n.dart';
import '../Provider/main_provider.dart';
import '../error_handler.dart';
import 'challenge_detail_page.dart';
import 'workout_detail_page.dart';
import '../map/map_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
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

  String translateKey(AppLocalizations localizations, String? key) {
    if (key == null) {
      print('Warning: Translation key is null');
      return 'Unknown';
    }
    switch (key) {
    // Challenges
      case 'cardioBlastTitle':
        return localizations.cardioBlastTitle;
      case 'cardioBlastSubtitle':
        return localizations.cardioBlastSubtitle;
      case 'fitIn15Title':
        return localizations.fitIn15Title;
      case 'fitIn15Subtitle':
        return localizations.fitIn15Subtitle;
      case 'fullBodyChallengeTitle':
        return localizations.fullBodyChallengeTitle;
      case 'fullBodyChallengeSubtitle':
        return localizations.fullBodyChallengeSubtitle;
      case 'plankChallengeTitle':
        return localizations.plankChallengeTitle;
      case 'plankChallengeSubtitle':
        return localizations.plankChallengeSubtitle;
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
        print('Warning: No translation found for key: $key');
        return key; // Fallback to raw key
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        if (provider.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ErrorHandler.showError(context, provider.errorMessage!);
            provider.clearError();
          });
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor ?? Theme.of(context).colorScheme.surface,
            elevation: 0,
            title: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.green[200], borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    localizations.startedCount(provider.started),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green[800]),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.blue[200], borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    localizations.completedCount(provider.completed),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[800]),
                  ),
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
                        decoration: InputDecoration(
                          labelText: localizations.search,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => provider.setSearchQuery(value),
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: provider.sortOption,
                        decoration: InputDecoration(
                          labelText: localizations.sortBy,
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: 'title-asc', child: Text(localizations.titleAsc)),
                          DropdownMenuItem(value: 'title-desc', child: Text(localizations.titleDesc)),
                          DropdownMenuItem(value: 'progress-asc', child: Text(localizations.progressAsc)),
                          DropdownMenuItem(value: 'progress-desc', child: Text(localizations.progressDesc)),
                          DropdownMenuItem(value: 'duration-asc', child: Text(localizations.durationAsc)),
                          DropdownMenuItem(value: 'duration-desc', child: Text(localizations.durationDesc)),
                        ],
                        onChanged: (value) {
                          if (value != null) provider.setSortOption(value);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: provider.challenges.isEmpty &&
                      provider.gymsNearMe.isEmpty &&
                      provider.workouts.isEmpty &&
                      provider.searchQuery.isNotEmpty
                      ? Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        localizations.notFound,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                      : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        localizations.challenges,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.challenges.length,
                          itemBuilder: (context, index) {
                            final challenge = provider.challenges[index];
                            final title = challenge['title'];
                            final subtitle = challenge['subtitle'];
                            final image = challenge['image'];
                            final progress = challenge['progress'];
                            if (title == null || subtitle == null || image == null || progress == null) {
                              return SizedBox.shrink();
                            }
                            final progressValue = double.tryParse(progress) ?? 0.0;
                            print('Progress for $title: $progressValue (parsed from $progress)');
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
                                      title: title,
                                      onProgressUpdate: (newProgress) => provider.saveProgress(title, newProgress),
                                      onMinutesUpdate: provider.updateTotalMinutes,
                                    ),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      final tween = Tween(begin: begin, end: end);
                                      final offsetAnimation = animation.drive(tween.chain(CurveTween(curve: Curves.easeInOut)));
                                      return SlideTransition(position: offsetAnimation, child: child);
                                    },
                                  ),
                                ),
                                child: Container(
                                  width: 250,
                                  margin: EdgeInsets.only(right: 16, bottom: 6),
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    elevation: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                          child: Image.asset(
                                            image,
                                            height: 150, // Reduced from 160 to 150
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => Container(
                                              height: 150,
                                              color: Colors.grey,
                                              child: Center(child: Text('Image not found')),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                translateKey(localizations, subtitle),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 6),
                                              LinearProgressIndicator(
                                                value: progressValue / 100,
                                                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                              Text(
                                                '$progress% ${localizations.percentCompleted}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).textTheme.bodyMedium?.color,
                                                ),
                                              ),
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
                      Text(
                        localizations.gymsNearMe,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: provider.gymsNearMe.length,
                          itemBuilder: (context, index) {
                            final gym = provider.gymsNearMe[index];
                            final title = gym['title'];
                            final subtitle = gym['subtitle'];
                            final address = gym['address'];
                            final image = gym['image'];
                            if (title == null || subtitle == null || address == null || image == null) {
                              return SizedBox.shrink();
                            }
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
                                  MaterialPageRoute(builder: (_) => MapPage(gymsNearMe: [provider.gymsNearMe[index]])),
                                ),
                                child: Container(
                                  width: 250,
                                  margin: EdgeInsets.only(right: 16, bottom: 6),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: 250),
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                      elevation: 6,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                            child: Image.asset(
                                              image,
                                              height: 150, // Reduced from 160 to 150
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) => Container(
                                                height: 150,
                                                color: Colors.grey,
                                                child: Center(child: Text('Image not found')),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  translateKey(localizations, title),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).textTheme.bodyMedium?.color,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  translateKey(localizations, address),
                                                  style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        localizations.workoutPlans,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 16),
                      ListView.builder(
                        itemCount: provider.workouts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final workout = provider.workouts[index];
                          final title = workout['title'];
                          final duration = workout['duration'];
                          final image = workout['image'];
                          final progress = workout['progress'];
                          if (title == null || duration == null || image == null || progress == null) {
                            return SizedBox.shrink();
                          }
                          final progressValue = double.tryParse(progress) ?? 0.0;
                          print('Progress for $title: $progressValue (parsed from $progress)');
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
                                    title: title,
                                    onProgressUpdate: (progress) => provider.saveWorkoutProgress(title, progress),
                                  ),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    final tween = Tween(begin: begin, end: end);
                                    final offsetAnimation = animation.drive(tween.chain(CurveTween(curve: Curves.easeInOut)));
                                    return SlideTransition(position: offsetAnimation, child: child);
                                  },
                                ),
                              ),
                              child: Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: Image.asset(
                                    image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey,
                                      child: Center(child: Text('Image not found')),
                                    ),
                                  ),
                                  title: Text(
                                    translateKey(localizations, title),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        translateKey(localizations, duration),
                                      ),
                                      const SizedBox(height: 4),
                                      LinearProgressIndicator(
                                        value: progressValue / 100,
                                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      Text('$progress% ${localizations.percentCompleted}'),
                                    ],
                                  ),
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
      },
    );
  }
}