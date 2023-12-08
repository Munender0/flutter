import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Question {
  String questionText;
  List<String> options;
  int correctOption;

  Question({required this.questionText, required this.options, required this.correctOption});
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  List<Question> _questions = [
    Question(
      questionText: "Who was the first Emperor of the Maurya Dynasty?",
      options: ["Ashoka", "Chandragupta Maurya", "Bindusara", "Chanakya"],
      correctOption: 1,
    ),
    Question(
      questionText: "The Indian National Congress was founded in which year?",
      options: ["1885", "1905", "1947", "1921"],
      correctOption: 0,
    ),
    Question(
      questionText: "Which Mughal emperor built the Taj Mahal?",
      options: ["Akbar", "Jahangir", "Aurangzeb", "Shah Jahan"],
      correctOption: 3,
    ),
    Question(
      questionText: "Who was the first woman Prime Minister of India?",
      options: ["Sonia Gandhi", "Indira Gandhi", "Sushma Swaraj", "Mayawati"],
      correctOption: 1,
    ),
    Question(
      questionText: "Which Indian leader is known as the 'Iron Man of India'?",
      options: ["Jawaharlal Nehru", "Sardar Patel", "Lal Bahadur Shastri", "Subhas Chandra Bose"],
      correctOption: 1,
    ),
    Question(
      questionText: "The Indian Rebellion of 1857 started in which city?",
      options: ["Delhi", "Lucknow", "Kanpur", "Meerut"],
      correctOption: 3,
    ),
  ];

  void _submitAnswer(int selectedOption) {
    if (selectedOption == _questions[_currentQuestionIndex].correctOption) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Quiz Result"),
          content: Text("Your Score: $_score out of ${_questions.length}"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _restartQuiz(); // Restart the quiz
              },
              child: Text("Restart Quiz"),
            ),
          ],
        );
      },
    );
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Indian History Quiz"),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.black,
          child: _currentQuestionIndex < _questions.length
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _questions[_currentQuestionIndex].questionText,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      children: _questions[_currentQuestionIndex]
                          .options
                          .asMap()
                          .entries
                          .map(
                            (entry) => GestureDetector(
                              onTap: () => _submitAnswer(entry.key),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                padding: EdgeInsets.all(10.0),
                                color: Colors.blue,
                                child: Text(
                                  entry.value,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () => _submitAnswer(-1), // -1 indicates no option selected
                      child: Text("Submit"),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Quiz Completed!",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _restartQuiz,
                      child: Text("Restart Quiz"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData.dark(),
      home: QuizApp(),
    );
  }
}
