import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final String lessonTitle;
  final String language;
  final String lessonType;
  final VoidCallback onTryAgain;

  const ResultPage({
    Key? key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.lessonTitle,
    required this.language,
    required this.lessonType,
    required this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final score = ((correctAnswers / totalQuestions) * 100).round();
    final isPerfect = score == 100;
    final isGood = score >= 80;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isPerfect
                    ? (language == 'English' ? 'Perfect!' : 'Hoàn hảo!')
                    : isGood
                        ? (language == 'English'
                            ? 'Great Job!'
                            : 'Làm tốt lắm!')
                        : (language == 'English'
                            ? 'Keep Trying!'
                            : 'Cố gắng lên!'),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      lessonTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: isPerfect
                            ? Colors.yellow
                            : isGood
                                ? Colors.green[100]
                                : Colors.orange[100],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isPerfect
                              ? Colors.orange
                              : isGood
                                  ? Colors.green
                                  : Colors.orange,
                          width: 8,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$score%',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: isPerfect
                                ? Colors.orange
                                : isGood
                                    ? Colors.green
                                    : Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('✅', style: TextStyle(fontSize: 32)),
                            const SizedBox(height: 8),
                            Text(
                              '$correctAnswers',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              language == 'English' ? 'Correct' : 'Đúng',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('❌', style: TextStyle(fontSize: 32)),
                            const SizedBox(height: 8),
                            Text(
                              '${totalQuestions - correctAnswers}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              language == 'English' ? 'Wrong' : 'Sai',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    language == 'English' ? 'Back to Home' : 'Về trang chủ',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: const BorderSide(color: Colors.teal, width: 2),
                  ),
                  child: Text(
                    language == 'English' ? 'Try Again' : 'Thử lại',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
