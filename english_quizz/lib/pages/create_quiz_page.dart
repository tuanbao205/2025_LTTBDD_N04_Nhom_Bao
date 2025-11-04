import 'package:flutter/material.dart';

class CreateQuizPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onQuizCreated;

  const CreateQuizPage({Key? key, required this.onQuizCreated}) : super(key: key);

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final TextEditingController _titleController = TextEditingController();
  final List<Map<String, dynamic>> _questions = [];

  void _addQuestion() {
    setState(() {
      _questions.add({
        'question': '',
        'options': ['', '', '', ''],
        'correct': 0,
      });
    });
  }

  void _saveQuiz() {
    if (_titleController.text.isEmpty || _questions.isEmpty) return;
    widget.onQuizCreated({
      'title': _titleController.text,
      'questions': _questions,
      'played': 0,          
      'bestScore': 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Quiz Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final q = _questions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (val) => q['question'] = val,
                            decoration: InputDecoration(
                              labelText: 'Question ${index + 1}',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(4, (i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: TextField(
                                onChanged: (val) => q['options'][i] = val,
                                decoration: InputDecoration(
                                  labelText: 'Option ${i + 1}',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            );
                          }),
                          DropdownButton<int>(
                            value: q['correct'],
                            onChanged: (val) {
                              setState(() => q['correct'] = val!);
                            },
                            items: List.generate(4, (i) {
                              return DropdownMenuItem(
                                value: i,
                                child: Text('Correct: Option ${i + 1}'),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _addQuestion,
              icon: const Icon(Icons.add),
              label: const Text('Add Question'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Save Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
