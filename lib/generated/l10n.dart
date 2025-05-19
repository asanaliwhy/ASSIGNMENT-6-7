import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_kk.dart';
import 'l10n_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MyFitnessPal'**
  String get appTitle;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @surname.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get surname;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @signInWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Facebook'**
  String get signInWithFacebook;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @exercises.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get exercises;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @titleAsc.
  ///
  /// In en, this message translates to:
  /// **'Title (A-Z)'**
  String get titleAsc;

  /// No description provided for @titleDesc.
  ///
  /// In en, this message translates to:
  /// **'Title (Z-A)'**
  String get titleDesc;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @progressAsc.
  ///
  /// In en, this message translates to:
  /// **'Progress (Low to High)'**
  String get progressAsc;

  /// No description provided for @progressDesc.
  ///
  /// In en, this message translates to:
  /// **'Progress (High to Low)'**
  String get progressDesc;

  /// No description provided for @durationAsc.
  ///
  /// In en, this message translates to:
  /// **'Duration (Short to Long)'**
  String get durationAsc;

  /// No description provided for @durationDesc.
  ///
  /// In en, this message translates to:
  /// **'Duration (Long to Short)'**
  String get durationDesc;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get notFound;

  /// No description provided for @challenges.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challenges;

  /// No description provided for @gymsNearMe.
  ///
  /// In en, this message translates to:
  /// **'Gyms Near Me'**
  String get gymsNearMe;

  /// No description provided for @workoutPlans.
  ///
  /// In en, this message translates to:
  /// **'Workout Plans'**
  String get workoutPlans;

  /// No description provided for @started.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get started;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @completedStats.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedStats;

  /// No description provided for @workouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get workouts;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @overallProgress.
  ///
  /// In en, this message translates to:
  /// **'Overall Progress'**
  String get overallProgress;

  /// No description provided for @weekNumber.
  ///
  /// In en, this message translates to:
  /// **'Week {weekIndex}'**
  String weekNumber(Object weekIndex);

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @newPost.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get newPost;

  /// No description provided for @editPost.
  ///
  /// In en, this message translates to:
  /// **'Edit Post'**
  String get editPost;

  /// No description provided for @deletePost.
  ///
  /// In en, this message translates to:
  /// **'Delete Post'**
  String get deletePost;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @enterPostTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter post title'**
  String get enterPostTitle;

  /// No description provided for @postText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get postText;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @shareThoughts.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts...'**
  String get shareThoughts;

  /// No description provided for @fillBothFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in both fields'**
  String get fillBothFields;

  /// No description provided for @postCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get postCancel;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @postSubmit.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get postSubmit;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// No description provided for @postSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get postSave;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @postDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this post?'**
  String get postDeleteConfirm;

  /// No description provided for @confirmDeletePost.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this post?'**
  String get confirmDeletePost;

  /// No description provided for @postDeleteYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get postDeleteYes;

  /// No description provided for @postDeleteNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get postDeleteNo;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @likes.
  ///
  /// In en, this message translates to:
  /// **'{count} Likes'**
  String likes(Object count);

  /// No description provided for @likesLabel.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get likesLabel;

  /// No description provided for @bodyPart.
  ///
  /// In en, this message translates to:
  /// **'Body Part'**
  String get bodyPart;

  /// No description provided for @equipment.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get equipment;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @bodyPartLabel.
  ///
  /// In en, this message translates to:
  /// **'Body Part:'**
  String get bodyPartLabel;

  /// No description provided for @equipmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Equipment:'**
  String get equipmentLabel;

  /// No description provided for @difficultyLabel.
  ///
  /// In en, this message translates to:
  /// **'Difficulty:'**
  String get difficultyLabel;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @stepsLabel.
  ///
  /// In en, this message translates to:
  /// **'Steps:'**
  String get stepsLabel;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'VIEW DETAILS'**
  String get viewDetails;

  /// No description provided for @enterGoal.
  ///
  /// In en, this message translates to:
  /// **'Enter your goal'**
  String get enterGoal;

  /// No description provided for @enterYourGoal.
  ///
  /// In en, this message translates to:
  /// **'Enter your goal'**
  String get enterYourGoal;

  /// No description provided for @addGoal.
  ///
  /// In en, this message translates to:
  /// **'Add Goal'**
  String get addGoal;

  /// No description provided for @fitnessGoals.
  ///
  /// In en, this message translates to:
  /// **'Fitness Goals'**
  String get fitnessGoals;

  /// No description provided for @editGoal.
  ///
  /// In en, this message translates to:
  /// **'Edit Goal'**
  String get editGoal;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @deleteGoal.
  ///
  /// In en, this message translates to:
  /// **'Delete Goal'**
  String get deleteGoal;

  /// No description provided for @goalProgress.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Complete'**
  String goalProgress(Object percent);

  /// No description provided for @percentCompleted.
  ///
  /// In en, this message translates to:
  /// **'% Completed'**
  String get percentCompleted;

  /// No description provided for @percentComplete.
  ///
  /// In en, this message translates to:
  /// **'% Complete'**
  String get percentComplete;

  /// No description provided for @deleteGoalConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this goal?'**
  String get deleteGoalConfirm;

  /// No description provided for @confirmDeleteGoal.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this goal?'**
  String get confirmDeleteGoal;

  /// No description provided for @saveGoal.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveGoal;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No Favorites'**
  String get noFavorites;

  /// No description provided for @resetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress'**
  String get resetProgress;

  /// No description provided for @resetProgressConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset progress for {title}?'**
  String resetProgressConfirm(Object title);

  /// No description provided for @confirmResetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset progress for {title}?'**
  String confirmResetProgress(Object title);

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @progressChart.
  ///
  /// In en, this message translates to:
  /// **'Progress Chart'**
  String get progressChart;

  /// No description provided for @yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get yourProgress;

  /// No description provided for @searchPosts.
  ///
  /// In en, this message translates to:
  /// **'Search Posts'**
  String get searchPosts;

  /// No description provided for @textNotFound.
  ///
  /// In en, this message translates to:
  /// **'Text not found'**
  String get textNotFound;

  /// No description provided for @gymLocation.
  ///
  /// In en, this message translates to:
  /// **'Gym Location'**
  String get gymLocation;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @kazakh.
  ///
  /// In en, this message translates to:
  /// **'Kazakh'**
  String get kazakh;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email.'**
  String get errorUserNotFound;

  /// No description provided for @errorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get errorWrongPassword;

  /// No description provided for @errorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'The email is already registered.'**
  String get errorEmailInUse;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'The email address is invalid.'**
  String get errorInvalidEmail;

  /// No description provided for @errorAuthGeneric.
  ///
  /// In en, this message translates to:
  /// **'An authentication error occurred.'**
  String get errorAuthGeneric;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred: {message}'**
  String errorGeneric(Object message);

  /// No description provided for @goalCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Goal cannot be empty'**
  String get goalCannotBeEmpty;

  /// No description provided for @errorFacebookCancel.
  ///
  /// In en, this message translates to:
  /// **'Facebook Sign-In cancelled'**
  String get errorFacebookCancel;

  /// No description provided for @errorFillFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in both fields'**
  String get errorFillFields;

  /// No description provided for @errorEnterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get errorEnterName;

  /// No description provided for @errorEnterSurname.
  ///
  /// In en, this message translates to:
  /// **'Enter your surname'**
  String get errorEnterSurname;

  /// No description provided for @errorEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter an email'**
  String get errorEnterEmail;

  /// No description provided for @errorPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get errorPasswordLength;

  /// No description provided for @errorLoadPosts.
  ///
  /// In en, this message translates to:
  /// **'Failed to load posts: {error}'**
  String errorLoadPosts(Object error);

  /// No description provided for @errorAddPost.
  ///
  /// In en, this message translates to:
  /// **'Failed to add post: {error}'**
  String errorAddPost(Object error);

  /// No description provided for @errorEditPost.
  ///
  /// In en, this message translates to:
  /// **'Failed to edit post: {error}'**
  String errorEditPost(Object error);

  /// No description provided for @errorDeletePost.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete post: {error}'**
  String errorDeletePost(Object error);

  /// No description provided for @errorToggleLike.
  ///
  /// In en, this message translates to:
  /// **'Failed to toggle like: {error}'**
  String errorToggleLike(Object error);

  /// No description provided for @weeklyFitnessChallengeTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly Fitness Challenge'**
  String get weeklyFitnessChallengeTitle;

  /// No description provided for @weeklyFitnessChallengeContent.
  ///
  /// In en, this message translates to:
  /// **'Join our 7-day cardio challenge and share your progress!'**
  String get weeklyFitnessChallengeContent;

  /// No description provided for @fitnessGuruAuthor.
  ///
  /// In en, this message translates to:
  /// **'FitnessGuru'**
  String get fitnessGuruAuthor;

  /// No description provided for @plankTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Plank Tips'**
  String get plankTipsTitle;

  /// No description provided for @plankTipsContent.
  ///
  /// In en, this message translates to:
  /// **'Struggling with planks? Try these tips to improve your form.'**
  String get plankTipsContent;

  /// No description provided for @coreMasterAuthor.
  ///
  /// In en, this message translates to:
  /// **'CoreMaster'**
  String get coreMasterAuthor;

  /// No description provided for @morningStretchRoutineTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning Stretch Routine'**
  String get morningStretchRoutineTitle;

  /// No description provided for @morningStretchRoutineContent.
  ///
  /// In en, this message translates to:
  /// **'Start your day with this 10-minute stretch to boost flexibility.'**
  String get morningStretchRoutineContent;

  /// No description provided for @yogaFanAuthor.
  ///
  /// In en, this message translates to:
  /// **'YogaFan'**
  String get yogaFanAuthor;

  /// No description provided for @proteinShakeRecipesTitle.
  ///
  /// In en, this message translates to:
  /// **'Protein Shake Recipes'**
  String get proteinShakeRecipesTitle;

  /// No description provided for @proteinShakeRecipesContent.
  ///
  /// In en, this message translates to:
  /// **'Share your favorite post-workout shake recipes here!'**
  String get proteinShakeRecipesContent;

  /// No description provided for @nutritionNutAuthor.
  ///
  /// In en, this message translates to:
  /// **'NutritionNut'**
  String get nutritionNutAuthor;

  /// No description provided for @errorLoadProgress.
  ///
  /// In en, this message translates to:
  /// **'Failed to load progress: {error}'**
  String errorLoadProgress(Object error);

  /// No description provided for @errorSaveChallengeProgress.
  ///
  /// In en, this message translates to:
  /// **'Failed to save challenge progress: {error}'**
  String errorSaveChallengeProgress(Object error);

  /// No description provided for @errorSaveWorkoutProgress.
  ///
  /// In en, this message translates to:
  /// **'Failed to save workout progress: {error}'**
  String errorSaveWorkoutProgress(Object error);

  /// No description provided for @errorResetProgress.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset progress: {error}'**
  String errorResetProgress(Object error);

  /// No description provided for @errorUpdateTotalMinutes.
  ///
  /// In en, this message translates to:
  /// **'Failed to update total minutes: {error}'**
  String errorUpdateTotalMinutes(Object error);

  /// No description provided for @errorChallengeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Challenge {title} not found'**
  String errorChallengeNotFound(Object title);

  /// No description provided for @errorWorkoutNotFound.
  ///
  /// In en, this message translates to:
  /// **'Workout {title} not found'**
  String errorWorkoutNotFound(Object title);

  /// No description provided for @fullBodyChallengeTitle.
  ///
  /// In en, this message translates to:
  /// **'Full Body Challenge'**
  String get fullBodyChallengeTitle;

  /// No description provided for @fullBodyChallengeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete Body Focus'**
  String get fullBodyChallengeSubtitle;

  /// No description provided for @plankChallengeTitle.
  ///
  /// In en, this message translates to:
  /// **'Plank Challenge'**
  String get plankChallengeTitle;

  /// No description provided for @plankChallengeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Build Core Strength'**
  String get plankChallengeSubtitle;

  /// No description provided for @fitIn15Title.
  ///
  /// In en, this message translates to:
  /// **'Fit in 15'**
  String get fitIn15Title;

  /// No description provided for @fitIn15Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Daily Workouts'**
  String get fitIn15Subtitle;

  /// No description provided for @cardioBlastTitle.
  ///
  /// In en, this message translates to:
  /// **'Cardio Blast'**
  String get cardioBlastTitle;

  /// No description provided for @cardioBlastSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Burn Calories Fast'**
  String get cardioBlastSubtitle;

  /// No description provided for @goldsGymVeniceTitle.
  ///
  /// In en, this message translates to:
  /// **'Gold\'s Gym Venice'**
  String get goldsGymVeniceTitle;

  /// No description provided for @goldsGymVeniceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The Mecca of Bodybuilding'**
  String get goldsGymVeniceSubtitle;

  /// No description provided for @goldsGymVeniceAddress.
  ///
  /// In en, this message translates to:
  /// **'360 Hampton Dr, Venice'**
  String get goldsGymVeniceAddress;

  /// No description provided for @planetFitnessTitle.
  ///
  /// In en, this message translates to:
  /// **'Planet Fitness'**
  String get planetFitnessTitle;

  /// No description provided for @planetFitnessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Affordable and local'**
  String get planetFitnessSubtitle;

  /// No description provided for @planetFitnessAddress.
  ///
  /// In en, this message translates to:
  /// **'456 Fitness Rd, HealthyTown'**
  String get planetFitnessAddress;

  /// No description provided for @chestWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Chest Workout'**
  String get chestWorkoutTitle;

  /// No description provided for @chestWorkoutDuration.
  ///
  /// In en, this message translates to:
  /// **'30 minutes'**
  String get chestWorkoutDuration;

  /// No description provided for @legWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Leg Workout'**
  String get legWorkoutTitle;

  /// No description provided for @legWorkoutDuration.
  ///
  /// In en, this message translates to:
  /// **'45 minutes'**
  String get legWorkoutDuration;

  /// No description provided for @plankWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Plank'**
  String get plankWorkoutTitle;

  /// No description provided for @plankWorkoutDuration.
  ///
  /// In en, this message translates to:
  /// **'15 minutes'**
  String get plankWorkoutDuration;

  /// No description provided for @backWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Back Workout'**
  String get backWorkoutTitle;

  /// No description provided for @backWorkoutDuration.
  ///
  /// In en, this message translates to:
  /// **'40 minutes'**
  String get backWorkoutDuration;

  /// No description provided for @jumpingJacksName.
  ///
  /// In en, this message translates to:
  /// **'Jumping Jacks'**
  String get jumpingJacksName;

  /// No description provided for @totalDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Duration:'**
  String get totalDurationLabel;

  /// No description provided for @minutesLabel.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutesLabel;

  /// No description provided for @jumpingJacksDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 30 seconds'**
  String get jumpingJacksDuration;

  /// No description provided for @highKneesName.
  ///
  /// In en, this message translates to:
  /// **'High Knees'**
  String get highKneesName;

  /// No description provided for @highKneesDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 30 seconds'**
  String get highKneesDuration;

  /// No description provided for @burpeesName.
  ///
  /// In en, this message translates to:
  /// **'Burpees'**
  String get burpeesName;

  /// No description provided for @burpeesDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 15 reps'**
  String get burpeesDuration;

  /// Name of the Push-ups exercise
  ///
  /// In en, this message translates to:
  /// **'Push-ups'**
  String get pushUpsName;

  /// No description provided for @pushUpsDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 15 reps'**
  String get pushUpsDuration;

  /// Name of the Squats exercise
  ///
  /// In en, this message translates to:
  /// **'Squats'**
  String get squatsName;

  /// No description provided for @squatsDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 20 reps'**
  String get squatsDuration;

  /// No description provided for @plankName.
  ///
  /// In en, this message translates to:
  /// **'Plank'**
  String get plankName;

  /// No description provided for @plankDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 30 seconds'**
  String get plankDuration;

  /// No description provided for @standardPlankName.
  ///
  /// In en, this message translates to:
  /// **'Standard Plank'**
  String get standardPlankName;

  /// No description provided for @standardPlankDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 30 seconds'**
  String get standardPlankDuration;

  /// No description provided for @sidePlankName.
  ///
  /// In en, this message translates to:
  /// **'Side Plank'**
  String get sidePlankName;

  /// No description provided for @sidePlankDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 20 seconds'**
  String get sidePlankDuration;

  /// No description provided for @plankWithLegLiftName.
  ///
  /// In en, this message translates to:
  /// **'Plank with Leg Lift'**
  String get plankWithLegLiftName;

  /// No description provided for @plankWithLegLiftDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 20 seconds'**
  String get plankWithLegLiftDuration;

  /// No description provided for @mountainClimbersName.
  ///
  /// In en, this message translates to:
  /// **'Mountain Climbers'**
  String get mountainClimbersName;

  /// No description provided for @mountainClimbersDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 30 seconds'**
  String get mountainClimbersDuration;

  /// No description provided for @lungesName.
  ///
  /// In en, this message translates to:
  /// **'Lunges'**
  String get lungesName;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// No description provided for @lungesDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 15 reps'**
  String get lungesDuration;

  /// No description provided for @bicycleCrunchesName.
  ///
  /// In en, this message translates to:
  /// **'Bicycle Crunches'**
  String get bicycleCrunchesName;

  /// No description provided for @bicycleCrunchesDuration.
  ///
  /// In en, this message translates to:
  /// **'3 sets of 20 reps'**
  String get bicycleCrunchesDuration;

  /// Steps for performing Push-ups
  ///
  /// In en, this message translates to:
  /// **'Start in a plank position with hands shoulder-width apart.\nLower your body until your chest nearly touches the floor.\nPush back up to the starting position.\nRepeat for the desired number of reps.'**
  String get pushUpsSteps;

  /// Steps for performing Squats
  ///
  /// In en, this message translates to:
  /// **'Stand with feet shoulder-width apart.\nLower your body by bending your knees and hips.\nKeep your back straight and knees over toes.\nReturn to the starting position.\nRepeat for the desired number of reps.'**
  String get squatsSteps;

  /// Body part: Chest
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get bodyPartChest;

  /// Body part: Legs
  ///
  /// In en, this message translates to:
  /// **'Legs'**
  String get bodyPartLegs;

  /// No equipment required
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get equipmentNone;

  /// Equipment: Mat
  ///
  /// In en, this message translates to:
  /// **'Mat'**
  String get equipmentMat;

  /// Difficulty level: Beginner
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// Difficulty level: Intermediate
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// Difficulty level: Advanced
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// Steps for performing Plank
  ///
  /// In en, this message translates to:
  /// **'Get into position: Begin by lying face down on the floor or mat. Place your forearms on the ground, elbows under shoulders. Lift your body, keeping a straight line from head to heels. Hold for the desired time.'**
  String get plankSteps;

  /// Body part: Shoulders
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get bodyPartShoulders;

  /// Body part: Triceps
  ///
  /// In en, this message translates to:
  /// **'Triceps'**
  String get bodyPartTriceps;

  /// Body part: Glutes
  ///
  /// In en, this message translates to:
  /// **'Glutes'**
  String get bodyPartGlutes;

  /// Combined body parts: Chest, Shoulders, Triceps
  ///
  /// In en, this message translates to:
  /// **'Chest, Shoulders, Triceps'**
  String get bodyPartChestShouldersTriceps;

  /// Combined body parts: Legs, Glutes
  ///
  /// In en, this message translates to:
  /// **'Legs, Glutes'**
  String get bodyPartLegsGlutes;

  /// Body part: Core
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get bodyPartCore;

  /// Name of the exercise
  ///
  /// In en, this message translates to:
  /// **'Exercise {name}'**
  String exerciseName(Object name);

  /// Value of the body part
  ///
  /// In en, this message translates to:
  /// **'Body Part {value}'**
  String bodyPartValue(Object value);

  /// Value of the difficulty level
  ///
  /// In en, this message translates to:
  /// **'Difficulty {value}'**
  String difficultyValue(Object value);

  /// Value of the equipment
  ///
  /// In en, this message translates to:
  /// **'Equipment {value}'**
  String equipmentValue(Object value);

  /// Number of started challenges or workouts
  ///
  /// In en, this message translates to:
  /// **'{count} Started'**
  String startedCount(Object count);

  /// Number of completed challenges or workouts
  ///
  /// In en, this message translates to:
  /// **'{count} Completed'**
  String completedCount(Object count);

  /// No description provided for @percentLabel.
  ///
  /// In en, this message translates to:
  /// **'{value}%'**
  String percentLabel(Object value);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'kk': return AppLocalizationsKk();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
