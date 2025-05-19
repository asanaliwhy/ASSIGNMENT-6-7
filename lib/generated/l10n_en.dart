// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MyFitnessPal';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get surname => 'Surname';

  @override
  String get createAccount => 'Create an account';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get signInWithFacebook => 'Sign in with Facebook';

  @override
  String get home => 'Home';

  @override
  String get description => 'Description';

  @override
  String get progress => 'Progress';

  @override
  String get exercises => 'Exercises';

  @override
  String get community => 'Community';

  @override
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get search => 'Search';

  @override
  String get sortBy => 'Sort by';

  @override
  String get titleAsc => 'Title (A-Z)';

  @override
  String get titleDesc => 'Title (Z-A)';

  @override
  String get delete => 'Delete';

  @override
  String get progressAsc => 'Progress (Low to High)';

  @override
  String get progressDesc => 'Progress (High to Low)';

  @override
  String get durationAsc => 'Duration (Short to Long)';

  @override
  String get durationDesc => 'Duration (Long to Short)';

  @override
  String get notFound => 'Not found';

  @override
  String get challenges => 'Challenges';

  @override
  String get gymsNearMe => 'Gyms Near Me';

  @override
  String get workoutPlans => 'Workout Plans';

  @override
  String get started => 'Started';

  @override
  String get completed => 'Completed';

  @override
  String get completedStats => 'Completed';

  @override
  String get workouts => 'Workouts';

  @override
  String get minutes => 'Minutes';

  @override
  String get overallProgress => 'Overall Progress';

  @override
  String weekNumber(Object weekIndex) {
    return 'Week $weekIndex';
  }

  @override
  String get done => 'Done';

  @override
  String get newPost => 'New Post';

  @override
  String get editPost => 'Edit Post';

  @override
  String get deletePost => 'Delete Post';

  @override
  String get title => 'Title';

  @override
  String get enterPostTitle => 'Enter post title';

  @override
  String get postText => 'Text';

  @override
  String get text => 'Text';

  @override
  String get shareThoughts => 'Share your thoughts...';

  @override
  String get fillBothFields => 'Please fill in both fields';

  @override
  String get postCancel => 'Cancel';

  @override
  String get cancel => 'Cancel';

  @override
  String get postSubmit => 'Post';

  @override
  String get post => 'Post';

  @override
  String get postSave => 'Save';

  @override
  String get save => 'Save';

  @override
  String get postDeleteConfirm => 'Are you sure you want to delete this post?';

  @override
  String get confirmDeletePost => 'Are you sure you want to delete this post?';

  @override
  String get postDeleteYes => 'Yes';

  @override
  String get postDeleteNo => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String likes(Object count) {
    return '$count Likes';
  }

  @override
  String get likesLabel => 'Likes';

  @override
  String get bodyPart => 'Body Part';

  @override
  String get equipment => 'Equipment';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get bodyPartLabel => 'Body Part:';

  @override
  String get equipmentLabel => 'Equipment:';

  @override
  String get difficultyLabel => 'Difficulty:';

  @override
  String get steps => 'Steps';

  @override
  String get stepsLabel => 'Steps:';

  @override
  String get viewDetails => 'VIEW DETAILS';

  @override
  String get enterGoal => 'Enter your goal';

  @override
  String get enterYourGoal => 'Enter your goal';

  @override
  String get addGoal => 'Add Goal';

  @override
  String get fitnessGoals => 'Fitness Goals';

  @override
  String get editGoal => 'Edit Goal';

  @override
  String get goal => 'Goal';

  @override
  String get deleteGoal => 'Delete Goal';

  @override
  String goalProgress(Object percent) {
    return '$percent% Complete';
  }

  @override
  String get percentCompleted => '% Completed';

  @override
  String get percentComplete => '% Complete';

  @override
  String get deleteGoalConfirm => 'Are you sure you want to delete this goal?';

  @override
  String get confirmDeleteGoal => 'Are you sure you want to delete this goal?';

  @override
  String get saveGoal => 'Save';

  @override
  String get favorites => 'Favorites';

  @override
  String get noFavorites => 'No Favorites';

  @override
  String get resetProgress => 'Reset Progress';

  @override
  String resetProgressConfirm(Object title) {
    return 'Reset progress for $title?';
  }

  @override
  String confirmResetProgress(Object title) {
    return 'Reset progress for $title?';
  }

  @override
  String get reset => 'Reset';

  @override
  String get progressChart => 'Progress Chart';

  @override
  String get yourProgress => 'Your Progress';

  @override
  String get searchPosts => 'Search Posts';

  @override
  String get textNotFound => 'Text not found';

  @override
  String get gymLocation => 'Gym Location';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get kazakh => 'Kazakh';

  @override
  String get russian => 'Russian';

  @override
  String get errorUserNotFound => 'No user found for that email.';

  @override
  String get errorWrongPassword => 'Incorrect password.';

  @override
  String get errorEmailInUse => 'The email is already registered.';

  @override
  String get errorInvalidEmail => 'The email address is invalid.';

  @override
  String get errorAuthGeneric => 'An authentication error occurred.';

  @override
  String errorGeneric(Object message) {
    return 'An unexpected error occurred: $message';
  }

  @override
  String get goalCannotBeEmpty => 'Goal cannot be empty';

  @override
  String get errorFacebookCancel => 'Facebook Sign-In cancelled';

  @override
  String get errorFillFields => 'Please fill in both fields';

  @override
  String get errorEnterName => 'Enter your name';

  @override
  String get errorEnterSurname => 'Enter your surname';

  @override
  String get errorEnterEmail => 'Enter an email';

  @override
  String get errorPasswordLength => 'Password must be at least 6 characters';

  @override
  String errorLoadPosts(Object error) {
    return 'Failed to load posts: $error';
  }

  @override
  String errorAddPost(Object error) {
    return 'Failed to add post: $error';
  }

  @override
  String errorEditPost(Object error) {
    return 'Failed to edit post: $error';
  }

  @override
  String errorDeletePost(Object error) {
    return 'Failed to delete post: $error';
  }

  @override
  String errorToggleLike(Object error) {
    return 'Failed to toggle like: $error';
  }

  @override
  String get weeklyFitnessChallengeTitle => 'Weekly Fitness Challenge';

  @override
  String get weeklyFitnessChallengeContent => 'Join our 7-day cardio challenge and share your progress!';

  @override
  String get fitnessGuruAuthor => 'FitnessGuru';

  @override
  String get plankTipsTitle => 'Plank Tips';

  @override
  String get plankTipsContent => 'Struggling with planks? Try these tips to improve your form.';

  @override
  String get coreMasterAuthor => 'CoreMaster';

  @override
  String get morningStretchRoutineTitle => 'Morning Stretch Routine';

  @override
  String get morningStretchRoutineContent => 'Start your day with this 10-minute stretch to boost flexibility.';

  @override
  String get yogaFanAuthor => 'YogaFan';

  @override
  String get proteinShakeRecipesTitle => 'Protein Shake Recipes';

  @override
  String get proteinShakeRecipesContent => 'Share your favorite post-workout shake recipes here!';

  @override
  String get nutritionNutAuthor => 'NutritionNut';

  @override
  String errorLoadProgress(Object error) {
    return 'Failed to load progress: $error';
  }

  @override
  String errorSaveChallengeProgress(Object error) {
    return 'Failed to save challenge progress: $error';
  }

  @override
  String errorSaveWorkoutProgress(Object error) {
    return 'Failed to save workout progress: $error';
  }

  @override
  String errorResetProgress(Object error) {
    return 'Failed to reset progress: $error';
  }

  @override
  String errorUpdateTotalMinutes(Object error) {
    return 'Failed to update total minutes: $error';
  }

  @override
  String errorChallengeNotFound(Object title) {
    return 'Challenge $title not found';
  }

  @override
  String errorWorkoutNotFound(Object title) {
    return 'Workout $title not found';
  }

  @override
  String get fullBodyChallengeTitle => 'Full Body Challenge';

  @override
  String get fullBodyChallengeSubtitle => 'Complete Body Focus';

  @override
  String get plankChallengeTitle => 'Plank Challenge';

  @override
  String get plankChallengeSubtitle => 'Build Core Strength';

  @override
  String get fitIn15Title => 'Fit in 15';

  @override
  String get fitIn15Subtitle => 'Quick Daily Workouts';

  @override
  String get cardioBlastTitle => 'Cardio Blast';

  @override
  String get cardioBlastSubtitle => 'Burn Calories Fast';

  @override
  String get goldsGymVeniceTitle => 'Gold\'s Gym Venice';

  @override
  String get goldsGymVeniceSubtitle => 'The Mecca of Bodybuilding';

  @override
  String get goldsGymVeniceAddress => '360 Hampton Dr, Venice';

  @override
  String get planetFitnessTitle => 'Planet Fitness';

  @override
  String get planetFitnessSubtitle => 'Affordable and local';

  @override
  String get planetFitnessAddress => '456 Fitness Rd, HealthyTown';

  @override
  String get chestWorkoutTitle => 'Chest Workout';

  @override
  String get chestWorkoutDuration => '30 minutes';

  @override
  String get legWorkoutTitle => 'Leg Workout';

  @override
  String get legWorkoutDuration => '45 minutes';

  @override
  String get plankWorkoutTitle => 'Plank';

  @override
  String get plankWorkoutDuration => '15 minutes';

  @override
  String get backWorkoutTitle => 'Back Workout';

  @override
  String get backWorkoutDuration => '40 minutes';

  @override
  String get jumpingJacksName => 'Jumping Jacks';

  @override
  String get totalDurationLabel => 'Total Duration:';

  @override
  String get minutesLabel => 'min';

  @override
  String get jumpingJacksDuration => '3 sets of 30 seconds';

  @override
  String get highKneesName => 'High Knees';

  @override
  String get highKneesDuration => '3 sets of 30 seconds';

  @override
  String get burpeesName => 'Burpees';

  @override
  String get burpeesDuration => '3 sets of 15 reps';

  @override
  String get pushUpsName => 'Push-ups';

  @override
  String get pushUpsDuration => '3 sets of 15 reps';

  @override
  String get squatsName => 'Squats';

  @override
  String get squatsDuration => '3 sets of 20 reps';

  @override
  String get plankName => 'Plank';

  @override
  String get plankDuration => '3 sets of 30 seconds';

  @override
  String get standardPlankName => 'Standard Plank';

  @override
  String get standardPlankDuration => '3 sets of 30 seconds';

  @override
  String get sidePlankName => 'Side Plank';

  @override
  String get sidePlankDuration => '3 sets of 20 seconds';

  @override
  String get plankWithLegLiftName => 'Plank with Leg Lift';

  @override
  String get plankWithLegLiftDuration => '3 sets of 20 seconds';

  @override
  String get mountainClimbersName => 'Mountain Climbers';

  @override
  String get mountainClimbersDuration => '3 sets of 30 seconds';

  @override
  String get lungesName => 'Lunges';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get lungesDuration => '3 sets of 15 reps';

  @override
  String get bicycleCrunchesName => 'Bicycle Crunches';

  @override
  String get bicycleCrunchesDuration => '3 sets of 20 reps';

  @override
  String get pushUpsSteps => 'Start in a plank position with hands shoulder-width apart.\nLower your body until your chest nearly touches the floor.\nPush back up to the starting position.\nRepeat for the desired number of reps.';

  @override
  String get squatsSteps => 'Stand with feet shoulder-width apart.\nLower your body by bending your knees and hips.\nKeep your back straight and knees over toes.\nReturn to the starting position.\nRepeat for the desired number of reps.';

  @override
  String get bodyPartChest => 'Chest';

  @override
  String get bodyPartLegs => 'Legs';

  @override
  String get equipmentNone => 'None';

  @override
  String get equipmentMat => 'Mat';

  @override
  String get beginner => 'Beginner';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get advanced => 'Advanced';

  @override
  String get plankSteps => 'Get into position: Begin by lying face down on the floor or mat. Place your forearms on the ground, elbows under shoulders. Lift your body, keeping a straight line from head to heels. Hold for the desired time.';

  @override
  String get bodyPartShoulders => 'Shoulders';

  @override
  String get bodyPartTriceps => 'Triceps';

  @override
  String get bodyPartGlutes => 'Glutes';

  @override
  String get bodyPartChestShouldersTriceps => 'Chest, Shoulders, Triceps';

  @override
  String get bodyPartLegsGlutes => 'Legs, Glutes';

  @override
  String get bodyPartCore => 'Core';

  @override
  String exerciseName(Object name) {
    return 'Exercise $name';
  }

  @override
  String bodyPartValue(Object value) {
    return 'Body Part $value';
  }

  @override
  String difficultyValue(Object value) {
    return 'Difficulty $value';
  }

  @override
  String equipmentValue(Object value) {
    return 'Equipment $value';
  }

  @override
  String startedCount(Object count) {
    return '$count Started';
  }

  @override
  String completedCount(Object count) {
    return '$count Completed';
  }

  @override
  String percentLabel(Object value) {
    return '$value%';
  }
}
