import 'package:flutter/material.dart';
import '../pages/result_page.dart';

class QuizPage extends StatefulWidget {
  final String lessonTitle;
  final String lessonType;
  final String language;
  final Function(String, int, String) onQuizComplete;
  final List<Map<String, dynamic>>? customQuestions;

  const QuizPage({
    Key? key,
    required this.lessonTitle,
    required this.lessonType,
    required this.language,
    required this.onQuizComplete,
    this.customQuestions,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  String? selectedAnswer;
  int correctAnswers = 0;
  bool hasAnswered = false;

  List<Map<String, dynamic>> get questions {
    if (widget.lessonType == 'Vocabulary') {
      return [
        {
          'question_en': 'He was too shy to ______ to strangers.',
          'question_vi': 'Anh ấy quá nhút nhát để ______ với người lạ.',
          'options': ['talk', 'talking', 'talked', 'be talked'],
          'correct': 0,
        },
        {
          'question_en': 'I need to ______ my vocabulary for the exam.',
          'question_vi': 'Tôi cần ______ vốn từ vựng cho kỳ thi.',
          'options': ['expand', 'expanding', 'expanded', 'expands'],
          'correct': 0,
        },
        {
          'question_en': 'She can ______ three languages fluently.',
          'question_vi': 'Cô ấy có thể ______ ba ngôn ngữ trôi chảy.',
          'options': ['spoke', 'speaking', 'speak', 'speaks'],
          'correct': 2,
        },
        {
          'question_en': 'The teacher asked us to ______ new words.',
          'question_vi': 'Giáo viên yêu cầu chúng tôi ______ từ mới.',
          'options': ['memorize', 'memorizing', 'memorized', 'memorizes'],
          'correct': 0,
        },
        {
          'question_en': 'He wants to ______ his pronunciation.',
          'question_vi': 'Anh ấy muốn ______ cách phát âm của mình.',
          'options': ['improving', 'improved', 'improve', 'improves'],
          'correct': 2,
        },
      ];
    } else if (widget.lessonType == 'Custom' && widget.customQuestions != null) {
      return widget.customQuestions!;
    } else {
      return [
        {
          'question_en': 'She ______ English for 5 years.',
          'question_vi': 'Cô ấy ______ tiếng Anh được 5 năm.',
          'options': ['study', 'studies', 'has studied', 'studying'],
          'correct': 2,
        },
        {
          'question_en': 'They ______ to the park yesterday.',
          'question_vi': 'Họ ______ đến công viên hôm qua.',
          'options': ['go', 'goes', 'went', 'going'],
          'correct': 2,
        },
        {
          'question_en': 'I ______ a book right now.',
          'question_vi': 'Tôi ______ một quyển sách ngay bây giờ.',
          'options': ['read', 'reads', 'am reading', 'reading'],
          'correct': 2,
        },
        {
          'question_en': 'She is ______ than her sister.',
          'question_vi': 'Cô ấy ______ hơn chị gái của cô ấy.',
          'options': ['tall', 'taller', 'tallest', 'more tall'],
          'correct': 1,
        },
        {
          'question_en': 'If I ______ rich, I would travel the world.',
          'question_vi': 'Nếu tôi ______ giàu, tôi sẽ đi du lịch khắp thế giới.',
          'options': ['am', 'was', 'were', 'be'],
          'correct': 2,
        },
      ];
    }
  }

  int get totalQuestions => questions.length;

  void _checkAnswer(int index) {
    if (hasAnswered) return;

    setState(() {
      selectedAnswer = String.fromCharCode(65 + index);
      hasAnswered = true;
      if (index == questions[currentQuestion]['correct']) {
        correctAnswers++;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestion < totalQuestions - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        hasAnswered = false;
      });
    } else {
      int score = ((correctAnswers / totalQuestions) * 100).round();
      widget.onQuizComplete(widget.lessonType, score, widget.lessonTitle);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            correctAnswers: correctAnswers,
            totalQuestions: totalQuestions,
            lessonTitle: widget.lessonTitle,
            language: widget.language,
            lessonType: widget.lessonType,
            onTryAgain: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QuizPage(
                    lessonTitle: widget.lessonTitle,
                    lessonType: widget.lessonType,
                    language: widget.language,
                    onQuizComplete: widget.onQuizComplete,
                    customQuestions: widget.customQuestions,
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  void _retryQuestion() {
    setState(() {
      selectedAnswer = null;
      hasAnswered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final questionText = question.containsKey('question_en')
        ? (widget.language == 'English'
            ? question['question_en']
            : question['question_vi'])
        : question['question'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.pink[100],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: List.generate(
                            totalQuestions,
                            (index) => Container(
                              width: 8,
                              height: 8,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: index <= currentQuestion
                                    ? Colors.teal
                                    : Colors.grey[400],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            widget.language == 'English' ? 'Skip' : 'Bỏ qua',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.diamond, color: Colors.purple[300]),
                        const SizedBox(width: 8),
                        Text(
                          widget.language == 'English'
                              ? 'Correct Word'
                              : 'Từ đúng',
                          style:
                              const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.teal[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        questionText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(
                      4,
                      (index) => _buildAnswerOption(
                        String.fromCharCode(65 + index),
                        question['options'][index],
                        index == question['correct'],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: hasAnswered ? _nextQuestion : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            hasAnswered ? Colors.teal : Colors.grey,
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        widget.language == 'English'
                            ? 'Continue'
                            : 'Tiếp tục',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  OutlinedButton(
                    onPressed: _retryQuestion,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: BorderSide(color: Colors.grey[400]!),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.refresh, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          widget.language == 'English'
                              ? 'Retry'
                              : 'Thử lại',
                          style:
                              const TextStyle(color: Colors.grey),
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

  Widget _buildAnswerOption(String letter, String text, bool isCorrect) {
    final isSelected = selectedAnswer == letter;
    final showResult = hasAnswered && isSelected;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _checkAnswer(letter.codeUnitAt(0) - 65),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: showResult && isCorrect
                ? Colors.green[100]
                : showResult && !isCorrect
                    ? Colors.red[100]
                    : Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: showResult && isCorrect
                  ? Colors.green
                  : showResult && !isCorrect
                      ? Colors.red
                      : Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: showResult && isCorrect
                      ? Colors.green
                      : showResult && !isCorrect
                          ? Colors.red
                          : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: Center(
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: showResult ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              if (showResult && isCorrect)
                const Icon(Icons.check_circle, color: Colors.green)
              else if (showResult && !isCorrect)
                const Icon(Icons.cancel, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}
