// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'MyFitnessPal';

  @override
  String get login => 'Кіру';

  @override
  String get register => 'Тіркелу';

  @override
  String get email => 'Электрондық пошта';

  @override
  String get password => 'Құпия сөз';

  @override
  String get name => 'Аты';

  @override
  String get surname => 'Тегі';

  @override
  String get createAccount => 'Тіркелгі жасау';

  @override
  String get signInWithGoogle => 'Google арқылы кіру';

  @override
  String get signInWithFacebook => 'Facebook арқылы кіру';

  @override
  String get home => 'Басты бет';

  @override
  String get description => 'Сипаттама';

  @override
  String get progress => 'Жетістіктер';

  @override
  String get exercises => 'Жаттығулар';

  @override
  String get community => 'Қауымдастық';

  @override
  String get profile => 'Профиль';

  @override
  String get logout => 'Шығу';

  @override
  String get search => 'Іздеу';

  @override
  String get sortBy => 'Сұрыптау';

  @override
  String get titleAsc => 'Атауы (А-Я)';

  @override
  String get titleDesc => 'Атауы (Я-А)';

  @override
  String get delete => 'Жою';

  @override
  String get progressAsc => 'Жетістік (төменнен жоғарыға)';

  @override
  String get progressDesc => 'Жетістік (жоғарыдан төменге)';

  @override
  String get durationAsc => 'Ұзақтығы (қысқа - ұзын)';

  @override
  String get durationDesc => 'Ұзақтығы (ұзын - қысқа)';

  @override
  String get notFound => 'Табылған жоқ';

  @override
  String get challenges => 'Сынақтар';

  @override
  String get gymsNearMe => 'Маған жақын жаттығу залдары';

  @override
  String get workoutPlans => 'Жаттығу жоспарлары';

  @override
  String get started => 'Басталды';

  @override
  String get completed => 'Аяқталды';

  @override
  String get completedStats => 'Аяқталған';

  @override
  String get workouts => 'Жаттығу';

  @override
  String get minutes => 'Минут';

  @override
  String get overallProgress => 'Жалпы жетістік';

  @override
  String weekNumber(Object weekIndex) {
    return '$weekIndex-апта';
  }

  @override
  String get done => 'Аяқталды';

  @override
  String get newPost => 'Жаңа жазба';

  @override
  String get editPost => 'Жазбаны өңдеу';

  @override
  String get deletePost => 'Жазбаны жою';

  @override
  String get title => 'Тақырып';

  @override
  String get enterPostTitle => 'Жазба тақырыбын енгізіңіз';

  @override
  String get postText => 'Мәтін';

  @override
  String get text => 'Мәтін';

  @override
  String get shareThoughts => 'Ойларыңызды бөлісіңіз...';

  @override
  String get fillBothFields => 'Екі өрісті де толтырыңыз';

  @override
  String get postCancel => 'Бас тарту';

  @override
  String get cancel => 'Бас тарту';

  @override
  String get postSubmit => 'Жариялау';

  @override
  String get post => 'Жазба';

  @override
  String get postSave => 'Сақтау';

  @override
  String get save => 'Сақтау';

  @override
  String get postDeleteConfirm => 'Осы жазбаны жойғыңыз келетініне сенімдісіз бе?';

  @override
  String get confirmDeletePost => 'Осы жазбаны жойғыңыз келетініне сенімдісіз бе?';

  @override
  String get postDeleteYes => 'Иә';

  @override
  String get postDeleteNo => 'Жоқ';

  @override
  String get yes => 'Иә';

  @override
  String get no => 'Жоқ';

  @override
  String likes(Object count) {
    return '$count ұнады';
  }

  @override
  String get likesLabel => 'Ұнатулар';

  @override
  String get bodyPart => 'Дене бөлігі';

  @override
  String get equipment => 'Жабдықтар';

  @override
  String get difficulty => 'Қиындық деңгейі';

  @override
  String get bodyPartLabel => 'Дене бөлігі:';

  @override
  String get equipmentLabel => 'Жабдықтар:';

  @override
  String get difficultyLabel => 'Қиындық деңгейі:';

  @override
  String get steps => 'Қадамдар';

  @override
  String get stepsLabel => 'Қадамдар:';

  @override
  String get viewDetails => 'ЕГЖЕЙ-ТЕГЖЕЙІН КӨРУ';

  @override
  String get enterGoal => 'Мақсатыңызды енгізіңіз';

  @override
  String get enterYourGoal => 'Мақсатыңызды енгізіңіз';

  @override
  String get addGoal => 'Мақсат қосу';

  @override
  String get fitnessGoals => 'Фитнес мақсаттары';

  @override
  String get editGoal => 'Мақсатты өңдеу';

  @override
  String get goal => 'Мақсат';

  @override
  String get deleteGoal => 'Мақсатты жою';

  @override
  String goalProgress(Object percent) {
    return '$percent% Аяқталды';
  }

  @override
  String get percentCompleted => '% Аяқталды';

  @override
  String get percentComplete => '% Аяқталды';

  @override
  String get deleteGoalConfirm => 'Осы мақсатты жойғыңыз келе ме?';

  @override
  String get confirmDeleteGoal => 'Осы мақсатты жойғыңыз келе ме?';

  @override
  String get saveGoal => 'Мақсатты сақтау';

  @override
  String get favorites => 'Таңдаулылар';

  @override
  String get noFavorites => 'Тандаулыларсыз';

  @override
  String get resetProgress => 'Жетістікті қалпына келтіру';

  @override
  String resetProgressConfirm(Object title) {
    return '$title үшін прогресті қайта бастау керек пе?';
  }

  @override
  String confirmResetProgress(Object title) {
    return '$title үшін прогресті қайта бастау керек пе?';
  }

  @override
  String get reset => 'Қалпына келтіру';

  @override
  String get progressChart => 'Жетістік диаграммасы';

  @override
  String get yourProgress => 'Сіздің жетістігіңіз';

  @override
  String get searchPosts => 'Жазбаларды іздеу';

  @override
  String get textNotFound => 'Мәтін табылмады';

  @override
  String get gymLocation => 'Залдың орналасуы';

  @override
  String get settings => 'Баптаулар';

  @override
  String get language => 'Тіл';

  @override
  String get selectLanguage => 'Тілді таңдаңыз';

  @override
  String get english => 'Ағылшын';

  @override
  String get kazakh => 'Қазақ';

  @override
  String get russian => 'Орыс';

  @override
  String get errorUserNotFound => 'Бұл электрондық поштамен пайдаланушы табылмады.';

  @override
  String get errorWrongPassword => 'Құпия сөз қате.';

  @override
  String get errorEmailInUse => 'Бұл электрондық пошта тіркелген.';

  @override
  String get errorInvalidEmail => 'Электрондық пошта мекенжайы жарамсыз.';

  @override
  String get errorAuthGeneric => 'Аутентификация қатесі орын алды.';

  @override
  String errorGeneric(Object message) {
    return 'Күтпеген қате пайда болды: $message';
  }

  @override
  String get goalCannotBeEmpty => 'Мақсат бос болуы мүмкін емес';

  @override
  String get errorFacebookCancel => 'Facebook арқылы кіру тоқтатылды';

  @override
  String get errorFillFields => 'Екі өрісті де толтырыңыз';

  @override
  String get errorEnterName => 'Атыңызды енгізіңіз';

  @override
  String get errorEnterSurname => 'Тегіңізді енгізіңіз';

  @override
  String get errorEnterEmail => 'Электрондық поштаны енгізіңіз';

  @override
  String get errorPasswordLength => 'Құпия сөз кемінде 6 таңбадан тұруы керек';

  @override
  String errorLoadPosts(Object error) {
    return 'Жазбаларды жүктеу сәтсіз аяқталды: $error';
  }

  @override
  String errorAddPost(Object error) {
    return 'Жазба қосу сәтсіз аяқталды: $error';
  }

  @override
  String errorEditPost(Object error) {
    return 'Жазбаны өңдеу сәтсіз аяқталды: $error';
  }

  @override
  String errorDeletePost(Object error) {
    return 'Жазбаны жою сәтсіз аяқталды: $error';
  }

  @override
  String errorToggleLike(Object error) {
    return 'Ұнату/ұнатпау сәтсіз аяқталды: $error';
  }

  @override
  String get weeklyFitnessChallengeTitle => 'Апталық Фитнес Сынағы';

  @override
  String get weeklyFitnessChallengeContent => '7 күндік кардио сынағына қосылыңыз және жетістіктеріңізді бөлісіңіз!';

  @override
  String get fitnessGuruAuthor => 'ФитнесГуру';

  @override
  String get plankTipsTitle => 'Планк Бойынша Кеңестер';

  @override
  String get plankTipsContent => 'Планк жасауда қиындықтар бар ма? Формаңызды жақсарту үшін мына кеңестерді қолданып көріңіз.';

  @override
  String get coreMasterAuthor => 'НегізгіШебер';

  @override
  String get morningStretchRoutineTitle => 'Таңғы Созылу Рәсімі';

  @override
  String get morningStretchRoutineContent => 'Күніңізді икемділікті арттыратын 10 минуттық созылумен бастаңыз.';

  @override
  String get yogaFanAuthor => 'ЙогаЖанкүйері';

  @override
  String get proteinShakeRecipesTitle => 'Протеин Коктейль Рецепттері';

  @override
  String get proteinShakeRecipesContent => 'Жаттығудан кейінгі сүйікті коктейль рецепттеріңізді осында бөлісіңіз!';

  @override
  String get nutritionNutAuthor => 'ТамақтануМаманы';

  @override
  String errorLoadProgress(Object error) {
    return 'Жетістіктерді жүктеу сәтсіз аяқталды: $error';
  }

  @override
  String errorSaveChallengeProgress(Object error) {
    return 'Сынақ жетістіктерін сақтау сәтсіз аяқталды: $error';
  }

  @override
  String errorSaveWorkoutProgress(Object error) {
    return 'Жаттығу жетістіктерін сақтау сәтсіз аяқталды: $error';
  }

  @override
  String errorResetProgress(Object error) {
    return 'Жетістіктерді қалпына келтіру сәтсіз аяқталды: $error';
  }

  @override
  String errorUpdateTotalMinutes(Object error) {
    return 'Жалпы минуттарды жаңарту сәтсіз аяқталды: $error';
  }

  @override
  String errorChallengeNotFound(Object title) {
    return '$title сынағы табылмады';
  }

  @override
  String errorWorkoutNotFound(Object title) {
    return '$title жаттығуы табылмады';
  }

  @override
  String get fullBodyChallengeTitle => 'Толық Дене Сынағы';

  @override
  String get fullBodyChallengeSubtitle => 'Толық Дене Фокусы';

  @override
  String get plankChallengeTitle => 'Планк Сынағы';

  @override
  String get plankChallengeSubtitle => 'Негізгі Күшті Қалыптастыру';

  @override
  String get fitIn15Title => '15 Минутта Фитнес';

  @override
  String get fitIn15Subtitle => 'Жылдам Күнделікті Жаттығулар';

  @override
  String get cardioBlastTitle => 'Кардио Жарылысы';

  @override
  String get cardioBlastSubtitle => 'Калорияларды Жылдам Жағу';

  @override
  String get goldsGymVeniceTitle => 'Венециядағы Gold\'s Gym';

  @override
  String get goldsGymVeniceSubtitle => 'Бодибилдингтің Меккесі';

  @override
  String get goldsGymVeniceAddress => 'Венеция, Хэмптон Др, 360';

  @override
  String get planetFitnessTitle => 'Planet Fitness';

  @override
  String get planetFitnessSubtitle => 'Қолжетімді және жергілікті';

  @override
  String get planetFitnessAddress => 'Фитнес Жолы, 456';

  @override
  String get chestWorkoutTitle => 'Кеуде Жаттығуы';

  @override
  String get chestWorkoutDuration => '30 минут';

  @override
  String get legWorkoutTitle => 'Аяқ Жаттығуы';

  @override
  String get legWorkoutDuration => '45 минут';

  @override
  String get plankWorkoutTitle => 'Планк';

  @override
  String get plankWorkoutDuration => '15 минут';

  @override
  String get backWorkoutTitle => 'Арқа Жаттығуы';

  @override
  String get backWorkoutDuration => '40 минут';

  @override
  String get jumpingJacksName => 'Секіру Джектері';

  @override
  String get totalDurationLabel => 'Жалпы Ұзақтығы:';

  @override
  String get minutesLabel => 'мин';

  @override
  String get jumpingJacksDuration => '3 жиынты_Desktop development with C++_к 30 секунд';

  @override
  String get highKneesName => 'Жоғары Тізелер';

  @override
  String get highKneesDuration => '3 жиынтық 30 секунд';

  @override
  String get burpeesName => 'Бөрпелер';

  @override
  String get burpeesDuration => '3 жиынтық 15 қайталау';

  @override
  String get pushUpsName => 'Отжимания';

  @override
  String get pushUpsDuration => '3 жиынтық 15 қайталау';

  @override
  String get squatsName => 'Приседания';

  @override
  String get squatsDuration => '3 жиынтық 20 қайталау';

  @override
  String get plankName => 'Планк';

  @override
  String get plankDuration => '3 жиынтық 30 секунд';

  @override
  String get standardPlankName => 'Стандартты Планк';

  @override
  String get standardPlankDuration => '3 жиынтық 30 секунд';

  @override
  String get sidePlankName => 'Бүйірлік Планк';

  @override
  String get sidePlankDuration => '3 жиынтық 20 секунд';

  @override
  String get plankWithLegLiftName => 'Аяқты Көтерумен Планк';

  @override
  String get plankWithLegLiftDuration => '3 жиынтық 20 секунд';

  @override
  String get mountainClimbersName => 'Тау Альпинистері';

  @override
  String get mountainClimbersDuration => '3 жиынтық 30 секунд';

  @override
  String get lungesName => 'Қадамдар';

  @override
  String get unknownError => 'Белгісіз қате';

  @override
  String get lungesDuration => '3 жиынтық 15 қайталау';

  @override
  String get bicycleCrunchesName => 'Велосипедті Қысу';

  @override
  String get bicycleCrunchesDuration => '3 жиынтық 20 қайталау';

  @override
  String get pushUpsSteps => 'Қолдарды иық енінде орналастырып, планка позициясынан бастаңыз.\nДенеңізді кеуде еденге жақын болғанша түсіріңіз.\nБастапқы позицияға қайта көтеріңіз.\nҚалаған қайталау санын орындаңыз.';

  @override
  String get squatsSteps => 'Аяқтарды иық енінде орналастырып, тік тұрыңыз.\nТізе мен жамбасты бүгіп, денеңізді төмендетіңіз.\nАрқаңызды тік ұстаңыз және тізелеріңіз саусақтарыңыздың үстінде болсын.\nБастапқы позицияға оралыңыз.\nҚалаған қайталау санын орындаңыз.';

  @override
  String get bodyPartChest => 'Кеуде';

  @override
  String get bodyPartLegs => 'Аяқтар';

  @override
  String get equipmentNone => 'Ешқандай';

  @override
  String get equipmentMat => 'Төсеніш';

  @override
  String get beginner => 'Бастаушы';

  @override
  String get intermediate => 'Орташа';

  @override
  String get advanced => 'Жетілдірілген';

  @override
  String get plankSteps => 'Позицияға кіріңіз: Еденде немесе кілемде бетіңізді төмен қаратып жатыңыз. Білектеріңізді жерге қойыңыз, шынтақтар иық астында. Денеңізді көтеріңіз, басынан өкшеге дейін түзу сызық сақтаңыз. Қажетті уақыт ұстаңыз.';

  @override
  String get bodyPartShoulders => 'Иықтар';

  @override
  String get bodyPartTriceps => 'Трицепс';

  @override
  String get bodyPartGlutes => 'Бөкселер';

  @override
  String get bodyPartChestShouldersTriceps => 'Кеуде, Иықтар, Трицепс';

  @override
  String get bodyPartLegsGlutes => 'Аяқтар, Бөкселер';

  @override
  String get bodyPartCore => 'Іш бұлшықеттері';

  @override
  String exerciseName(Object name) {
    return 'Жаттығу $name';
  }

  @override
  String bodyPartValue(Object value) {
    return 'Дене бөлігі $value';
  }

  @override
  String difficultyValue(Object value) {
    return 'Қиындық деңгейі $value';
  }

  @override
  String equipmentValue(Object value) {
    return 'Жабдық $value';
  }

  @override
  String startedCount(Object count) {
    return '$count Бастау алған';
  }

  @override
  String completedCount(Object count) {
    return '$count Аяқталған';
  }

  @override
  String percentLabel(Object value) {
    return '$value%';
  }
}
