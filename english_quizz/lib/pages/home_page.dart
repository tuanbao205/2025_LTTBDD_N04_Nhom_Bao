import 'package:flutter/material.dart';
import '../data/translations.dart';
import '../pages/quiz_page.dart';

class HomePage extends StatelessWidget {
  final String userName;
  final String language;
  final Map<String, int> lessonCount;
  final Map<String, int> lessonBestScore;
  final Function(String, int, String) onLessonComplete;
  final List<Map<String, dynamic>> customQuizzes;

  const HomePage({
    Key? key,
    required this.userName,
    required this.language,
    required this.lessonCount,
    required this.lessonBestScore,
    required this.onLessonComplete,
    required this.customQuizzes,
  }) : super(key: key);

  Map<String, String> _getTranslation(String key) {
    return translations[key] ?? {'English': key, 'Vietnamese': key};
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getTranslation('home')[language]!,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Stack(
                        children: [
                          const Icon(Icons.notifications_outlined, size: 28),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: const Text(
                                '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    const MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Icon(Icons.flash_on, size: 28, color: Colors.orange),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 32, color: Colors.black87),
                children: [
                  TextSpan(text: '${_getTranslation('Quizz_english')[language]}\n'),
                  TextSpan(text: '${_getTranslation('mr')[language]} '),
                  TextSpan(
                    text: userName,
                    style: const TextStyle(
                      backgroundColor: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildLessonCard(
                      context,
                      _getTranslation('vocabulary')[language]!,
                      _getTranslation('vocab_desc')[language]!,
                      (lessonCount['Vocabulary'] ?? 0).toString(),
                      (lessonBestScore['Vocabulary'] ?? 0).toString(),
                      Colors.teal[100]!,
                      Colors.teal,
                      Icons.book,
                      'Vocabulary',
                    ),
                    const SizedBox(height: 20),
                    _buildLessonCard(
                      context,
                      _getTranslation('grammar')[language]!,
                      _getTranslation('grammar_desc')[language]!,
                      (lessonCount['Grammar'] ?? 0).toString(),
                      (lessonBestScore['Grammar'] ?? 0).toString(),
                      Colors.pink[50]!,
                      Colors.pink,
                      Icons.edit_note,
                      'Grammar',
                    ),
                    const SizedBox(height: 20),
                    // ✅ Thêm các quiz tự tạo
                    ...customQuizzes.map((quiz) {
                      return Column(
                        children: [
                          _buildLessonCard(
                            context,
                            quiz['title'],
                            'Custom Quiz',
                            (quiz['played'] ?? 0).toString(),     
                            (quiz['bestScore'] ?? 0).toString(),  
                            Colors.amber[50]!,
                            Colors.amber,
                            Icons.lightbulb,
                            'Custom',
                            quiz['questions'],
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonCard(
    BuildContext context,
    String title,
    String subtitle,
    String played,
    String bestScore,
    Color bgColor,
    Color badgeColor,
    IconData icon,
    String lessonType, [
    List<Map<String, dynamic>>? customQuestions,
  ]) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizPage(
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[300]!, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      language == 'English'
                          ? 'Training Game'
                          : 'Trò chơi luyện tập',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Icon(icon, color: badgeColor, size: 40),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          played,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          language == 'English' ? 'Played' : 'Đã chơi',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bestScore,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          language == 'English'
                              ? 'Best Score (%)'
                              : 'Điểm cao nhất (%)',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
