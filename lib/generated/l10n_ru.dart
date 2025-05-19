// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'MyFitnessPal';

  @override
  String get login => 'Войти';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get email => 'Электронная почта';

  @override
  String get password => 'Пароль';

  @override
  String get name => 'Имя';

  @override
  String get surname => 'Фамилия';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get signInWithGoogle => 'Войти через Google';

  @override
  String get signInWithFacebook => 'Войти через Facebook';

  @override
  String get home => 'Главная';

  @override
  String get description => 'Описание';

  @override
  String get progress => 'Прогресс';

  @override
  String get exercises => 'Упражнения';

  @override
  String get community => 'Сообщество';

  @override
  String get profile => 'Профиль';

  @override
  String get logout => 'Выйти';

  @override
  String get search => 'Поиск';

  @override
  String get sortBy => 'Сортировать по';

  @override
  String get titleAsc => 'Название (А-Я)';

  @override
  String get titleDesc => 'Название (Я-А)';

  @override
  String get delete => 'Удалить';

  @override
  String get progressAsc => 'Прогресс (от низкого к высокому)';

  @override
  String get progressDesc => 'Прогресс (от высокого к низкому)';

  @override
  String get durationAsc => 'Длительность (от короткой к длинной)';

  @override
  String get durationDesc => 'Длительность (от длинной к короткой)';

  @override
  String get notFound => 'Не найдено';

  @override
  String get challenges => 'Испытания';

  @override
  String get gymsNearMe => 'Спортзалы рядом';

  @override
  String get workoutPlans => 'Планы тренировок';

  @override
  String get started => 'Начато';

  @override
  String get completed => 'Завершено';

  @override
  String get completedStats => 'Завершено';

  @override
  String get workouts => 'Занятия';

  @override
  String get minutes => 'Минуты';

  @override
  String get overallProgress => 'Общий прогресс';

  @override
  String weekNumber(Object weekIndex) {
    return 'Неделя $weekIndex';
  }

  @override
  String get done => 'Готово';

  @override
  String get newPost => 'Новый пост';

  @override
  String get editPost => 'Редактировать пост';

  @override
  String get deletePost => 'Удалить пост';

  @override
  String get title => 'Заголовок';

  @override
  String get enterPostTitle => 'Введите заголовок поста';

  @override
  String get postText => 'Текст';

  @override
  String get text => 'Текст';

  @override
  String get shareThoughts => 'Поделитесь своими мыслями...';

  @override
  String get fillBothFields => 'Пожалуйста, заполните оба поля';

  @override
  String get postCancel => 'Отмена';

  @override
  String get cancel => 'Отмена';

  @override
  String get postSubmit => 'Опубликовать';

  @override
  String get post => 'Пост';

  @override
  String get postSave => 'Сохранить';

  @override
  String get save => 'Сохранить';

  @override
  String get postDeleteConfirm => 'Вы уверены, что хотите удалить этот пост?';

  @override
  String get confirmDeletePost => 'Вы уверены, что хотите удалить этот пост?';

  @override
  String get postDeleteYes => 'Да';

  @override
  String get postDeleteNo => 'Нет';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String likes(Object count) {
    return '$count Лайков';
  }

  @override
  String get likesLabel => 'Лайки';

  @override
  String get bodyPart => 'Часть тела';

  @override
  String get equipment => 'Оборудование';

  @override
  String get difficulty => 'Сложность';

  @override
  String get bodyPartLabel => 'Часть тела:';

  @override
  String get equipmentLabel => 'Оборудование:';

  @override
  String get difficultyLabel => 'Сложность:';

  @override
  String get steps => 'Шаги';

  @override
  String get stepsLabel => 'Шаги:';

  @override
  String get viewDetails => 'Посмотреть детали';

  @override
  String get enterGoal => 'Введите вашу цель';

  @override
  String get enterYourGoal => 'Введите вашу цель';

  @override
  String get addGoal => 'Добавить цель';

  @override
  String get fitnessGoals => 'Фитнес-цели';

  @override
  String get editGoal => 'Редактировать цель';

  @override
  String get goal => 'Цель';

  @override
  String get deleteGoal => 'Удалить цель';

  @override
  String goalProgress(Object percent) {
    return '$percent% Завершено';
  }

  @override
  String get percentCompleted => '% Завершено';

  @override
  String get percentComplete => '% Завершено';

  @override
  String get deleteGoalConfirm => 'Вы уверены, что хотите удалить эту цель?';

  @override
  String get confirmDeleteGoal => 'Вы уверены, что хотите удалить эту цель?';

  @override
  String get saveGoal => 'Сохранить';

  @override
  String get favorites => 'Избранное';

  @override
  String get noFavorites => 'Отсутвуют любимые упражнения';

  @override
  String get resetProgress => 'Сбросить прогресс';

  @override
  String resetProgressConfirm(Object title) {
    return 'Сбросить прогресс для $title?';
  }

  @override
  String confirmResetProgress(Object title) {
    return 'Сбросить прогресс для $title?';
  }

  @override
  String get reset => 'Сбросить';

  @override
  String get progressChart => 'График прогресса';

  @override
  String get yourProgress => 'Ваш прогресс';

  @override
  String get searchPosts => 'Поиск постов';

  @override
  String get textNotFound => 'Текст не найден';

  @override
  String get gymLocation => 'Местоположение спортзала';

  @override
  String get settings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get selectLanguage => 'Выбрать язык';

  @override
  String get english => 'Английский';

  @override
  String get kazakh => 'Казахский';

  @override
  String get russian => 'Русский';

  @override
  String get errorUserNotFound => 'Пользователь с таким email не найден.';

  @override
  String get errorWrongPassword => 'Неверный пароль.';

  @override
  String get errorEmailInUse => 'Этот email уже зарегистрирован.';

  @override
  String get errorInvalidEmail => 'Недействительный адрес электронной почты.';

  @override
  String get errorAuthGeneric => 'Произошла ошибка аутентификации.';

  @override
  String errorGeneric(Object message) {
    return 'Произошла непредвиденная ошибка: $message';
  }

  @override
  String get goalCannotBeEmpty => 'Цель не может быть пустой';

  @override
  String get errorFacebookCancel => 'Вход через Facebook отменен';

  @override
  String get errorFillFields => 'Пожалуйста, заполните оба поля';

  @override
  String get errorEnterName => 'Введите ваше имя';

  @override
  String get errorEnterSurname => 'Введите вашу фамилию';

  @override
  String get errorEnterEmail => 'Введите электронную почту';

  @override
  String get errorPasswordLength => 'Пароль должен содержать не менее 6 символов';

  @override
  String errorLoadPosts(Object error) {
    return 'Не удалось загрузить посты: $error';
  }

  @override
  String errorAddPost(Object error) {
    return 'Не удалось добавить пост: $error';
  }

  @override
  String errorEditPost(Object error) {
    return 'Не удалось отредактировать пост: $error';
  }

  @override
  String errorDeletePost(Object error) {
    return 'Не удалось удалить пост: $error';
  }

  @override
  String errorToggleLike(Object error) {
    return 'Не удалось переключить лайк: $error';
  }

  @override
  String get weeklyFitnessChallengeTitle => 'Еженедельное фитнес-испытание';

  @override
  String get weeklyFitnessChallengeContent => 'Присоединяйтесь к нашему 7-дневному кардио-испытанию и делитесь своим прогрессом!';

  @override
  String get fitnessGuruAuthor => 'ФитнесГуру';

  @override
  String get plankTipsTitle => 'Советы по планке';

  @override
  String get plankTipsContent => 'Трудности с планкой? Попробуйте эти советы, чтобы улучшить технику.';

  @override
  String get coreMasterAuthor => 'МастерКор';

  @override
  String get morningStretchRoutineTitle => 'Утренняя растяжка';

  @override
  String get morningStretchRoutineContent => 'Начните день с 10-минутной растяжки для повышения гибкости.';

  @override
  String get yogaFanAuthor => 'ФанатЙоги';

  @override
  String get proteinShakeRecipesTitle => 'Рецепты протеиновых коктейлей';

  @override
  String get proteinShakeRecipesContent => 'Делитесь своими любимыми рецептами коктейлей после тренировок здесь!';

  @override
  String get nutritionNutAuthor => 'СпециалистПоПитанию';

  @override
  String errorLoadProgress(Object error) {
    return 'Не удалось загрузить прогресс: $error';
  }

  @override
  String errorSaveChallengeProgress(Object error) {
    return 'Не удалось сохранить прогресс испытания: $error';
  }

  @override
  String errorSaveWorkoutProgress(Object error) {
    return 'Не удалось сохранить прогресс тренировки: $error';
  }

  @override
  String errorResetProgress(Object error) {
    return 'Не удалось сбросить прогресс: $error';
  }

  @override
  String errorUpdateTotalMinutes(Object error) {
    return 'Не удалось обновить общее время: $error';
  }

  @override
  String errorChallengeNotFound(Object title) {
    return 'Испытание $title не найдено';
  }

  @override
  String errorWorkoutNotFound(Object title) {
    return 'Тренировка $title не найдена';
  }

  @override
  String get fullBodyChallengeTitle => 'Полное Испытание Тела';

  @override
  String get fullBodyChallengeSubtitle => 'Фокус на Всё Тело';

  @override
  String get plankChallengeTitle => 'Испытание Планкой';

  @override
  String get plankChallengeSubtitle => 'Укрепление Корпуса';

  @override
  String get fitIn15Title => 'Фитнес за 15';

  @override
  String get fitIn15Subtitle => 'Быстрые Ежедневные Тренировки';

  @override
  String get cardioBlastTitle => 'Кардио Взрыв';

  @override
  String get cardioBlastSubtitle => 'Быстрое Сжигание Калорий';

  @override
  String get goldsGymVeniceTitle => 'Gold\'s Gym в Венеции';

  @override
  String get goldsGymVeniceSubtitle => 'Мекка Бодибилдинга';

  @override
  String get goldsGymVeniceAddress => 'Хэмптон Др, 360, Венеция';

  @override
  String get planetFitnessTitle => 'Planet Fitness';

  @override
  String get planetFitnessSubtitle => 'Доступно и местно';

  @override
  String get planetFitnessAddress => 'Фитнес Роуд, 456';

  @override
  String get chestWorkoutTitle => 'Тренировка Груди';

  @override
  String get chestWorkoutDuration => '30 минут';

  @override
  String get legWorkoutTitle => 'Тренировка Ног';

  @override
  String get legWorkoutDuration => '45 минут';

  @override
  String get plankWorkoutTitle => 'Планка';

  @override
  String get plankWorkoutDuration => '15 минут';

  @override
  String get backWorkoutTitle => 'Тренировка Спины';

  @override
  String get backWorkoutDuration => '40 минут';

  @override
  String get jumpingJacksName => 'Прыжки с разведением рук';

  @override
  String get totalDurationLabel => 'Общая продолжительность:';

  @override
  String get minutesLabel => 'мин';

  @override
  String get jumpingJacksDuration => '3 подхода по 30 секунд';

  @override
  String get highKneesName => 'Высокие колени';

  @override
  String get highKneesDuration => '3 подхода по 30 секунд';

  @override
  String get burpeesName => 'Бёрпи';

  @override
  String get burpeesDuration => '3 подхода по 15 повторений';

  @override
  String get pushUpsName => 'Отжимания';

  @override
  String get pushUpsDuration => '3 подхода по 15 повторений';

  @override
  String get squatsName => 'Приседания';

  @override
  String get squatsDuration => '3 подхода по 20 повторений';

  @override
  String get plankName => 'Планка';

  @override
  String get plankDuration => '3 подхода по 30 секунд';

  @override
  String get standardPlankName => 'Стандартная Планка';

  @override
  String get standardPlankDuration => '3 подхода по 30 секунд';

  @override
  String get sidePlankName => 'Боковая Планка';

  @override
  String get sidePlankDuration => '3 подхода по 20 секунд';

  @override
  String get plankWithLegLiftName => 'Планка с Подъемом Ноги';

  @override
  String get plankWithLegLiftDuration => '3 подхода по 20 секунд';

  @override
  String get mountainClimbersName => 'Скалолазы';

  @override
  String get mountainClimbersDuration => '3 подхода по 30 секунд';

  @override
  String get lungesName => 'Выпады';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get lungesDuration => '3 подхода по 15 повторений';

  @override
  String get bicycleCrunchesName => 'Велосипедные Скручивания';

  @override
  String get bicycleCrunchesDuration => '3 подхода по 20 повторений';

  @override
  String get pushUpsSteps => 'Начните в позиции планки, руки на ширине плеч.\nОпустите тело, пока грудь почти не коснется пола.\nВернитесь в исходное положение, отталкиваясь руками.\nПовторите нужное количество раз.';

  @override
  String get squatsSteps => 'Встаньте, ноги на ширине плеч.\nОпустите тело, сгибая колени и бедра.\nДержите спину прямо, колени над пальцами ног.\nВернитесь в исходное положение.\nПовторите нужное количество раз.';

  @override
  String get bodyPartChest => 'Грудь';

  @override
  String get bodyPartLegs => 'Ноги';

  @override
  String get equipmentNone => 'Нет';

  @override
  String get equipmentMat => 'Коврик';

  @override
  String get beginner => 'Новичок';

  @override
  String get intermediate => 'Средний';

  @override
  String get advanced => 'Продвинутый';

  @override
  String get plankSteps => 'Примите позицию: Лягте лицом вниз на пол или коврик. Поставьте предплечья на землю, локти под плечами. Поднимите тело, сохраняя прямую линию от головы до пяток. Удерживайте нужное время.';

  @override
  String get bodyPartShoulders => 'Плечи';

  @override
  String get bodyPartTriceps => 'Трицепсы';

  @override
  String get bodyPartGlutes => 'Ягодицы';

  @override
  String get bodyPartChestShouldersTriceps => 'Грудь, Плечи, Трицепсы';

  @override
  String get bodyPartLegsGlutes => 'Ноги, Ягодицы';

  @override
  String get bodyPartCore => 'Кор';

  @override
  String exerciseName(Object name) {
    return 'Упражнение $name';
  }

  @override
  String bodyPartValue(Object value) {
    return 'Часть тела $value';
  }

  @override
  String difficultyValue(Object value) {
    return 'Сложность $value';
  }

  @override
  String equipmentValue(Object value) {
    return 'Оборудование $value';
  }

  @override
  String startedCount(Object count) {
    return '$count Начатых';
  }

  @override
  String completedCount(Object count) {
    return '$count Завершённых';
  }

  @override
  String percentLabel(Object value) {
    return '$value%';
  }
}
