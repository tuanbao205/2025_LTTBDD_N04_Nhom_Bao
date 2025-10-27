import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/achievements_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const LanguageLearningApp());
}

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: false,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  String userName = "TuanBao";
  String selectedLanguage = "English";
  List<Map<String, dynamic>> customQuizzes = [];
  List<Map<String, dynamic>> quizHistory = [];
  
  Map<String, int> lessonCount = {
    'Vocabulary': 0,
    'Grammar': 0,
  };
  
  Map<String, int> lessonBestScore = {
    'Vocabulary': 0,
    'Grammar': 0,
  };

void _addQuizHistory(String lessonType, int score, String lessonTitle) {
  setState(() {
    quizHistory.add({
      'lessonType': lessonType,
      'lessonTitle': lessonTitle,
      'score': score,
      'date': DateTime.now(),
    });

    // ✅ Nếu là quiz hệ thống (Vocabulary, Grammar)
    if (lessonType != 'Custom') {
      lessonCount[lessonType] = (lessonCount[lessonType] ?? 0) + 1;

      if (score > (lessonBestScore[lessonType] ?? 0)) {
        lessonBestScore[lessonType] = score;
      }
    } 
    // ✅ Nếu là quiz tự tạo (Custom)
    else {
      final quizIndex = customQuizzes.indexWhere((q) => q['title'] == lessonTitle);
      if (quizIndex != -1) {
        customQuizzes[quizIndex]['played'] = 
            (customQuizzes[quizIndex]['played'] ?? 0) + 1;

        final best = (customQuizzes[quizIndex]['bestScore'] ?? 0);
        if (score > best) {
          customQuizzes[quizIndex]['bestScore'] = score;
        }
      }
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(
            userName: userName,
            language: selectedLanguage,
            lessonCount: lessonCount,
            lessonBestScore: lessonBestScore,
            onLessonComplete: _addQuizHistory,
            customQuizzes: customQuizzes,
          ),
          AchievementsPage(
          ),
          SettingsPage(
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.emoji_events, 1),
              _buildNavItem(Icons.settings, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.yellow : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.teal : Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}
