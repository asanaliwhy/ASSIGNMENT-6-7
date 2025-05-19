import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'auth/auth_page.dart';
import 'theme_button.dart';
import 'screens/item_detail_page.dart';
import 'screens/profile_page.dart';
import 'screens/main_page.dart';
import 'screens/progress_page.dart';
import 'screens/community_page.dart';
import 'screens/settings_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'Provider/community_provider.dart';
import 'Provider/main_provider.dart';
import 'Provider/language_provider.dart';
import 'package:final_2/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  MaterialColor _primarySwatch = Colors.deepPurple;

  void _changeThemeMode(bool useLightMode) {
    setState(() {
      _themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommunityProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            title: 'MyFitnessPal',
            debugShowCheckedModeBanner: false,
            themeMode: _themeMode,
            theme: ThemeData(primarySwatch: _primarySwatch, brightness: Brightness.light),
            darkTheme: ThemeData(primarySwatch: _primarySwatch, brightness: Brightness.dark),
            locale: languageProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('kk'),
              Locale('ru'),
            ],
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return HomePage(changeThemeMode: _changeThemeMode);
                }
                return const AuthPage();
              },
            ),
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final Function(bool) changeThemeMode;

  const HomePage({super.key, required this.changeThemeMode});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pages = [
      const MainPage(),
      const ProgressPage(),
      const ItemDetailPage(),
      const CommunityPage(),
       ProfilePage(),
    ];
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? localizations.appTitle
              : _selectedIndex == 1
              ? localizations.progress
              : _selectedIndex == 2
              ? localizations.exercises
              : _selectedIndex == 3
              ? localizations.community
              : localizations.profile,
        ),
        actions: [
          ThemeButton(changeThemeMode: widget.changeThemeMode),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
            tooltip: localizations.settings,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              await FacebookAuth.instance.logOut();
            },
            tooltip: localizations.logout,
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: localizations.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.trending_up),
            label: localizations.progress,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center),
            label: localizations.exercises,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group),
            label: localizations.community,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: localizations.profile,
          ),
        ],
      ),
    );
  }
}