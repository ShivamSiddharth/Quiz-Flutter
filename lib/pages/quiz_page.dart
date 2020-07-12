import 'package:flutter/material.dart';
import '../utils/question.dart';
import '../utils/quiz.dart';
import '../ui/question_text.dart';

import '../ui/answer_button.dart';
import '../ui/correct_wrong_overlay.dart';
import '../pages/score_page.dart';

class QuizPage extends StatefulWidget
{


  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage>
{

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("SHIVAM IS HUMAN" , true),
    new Question("IS SHIVAM YOUR FRIEND" , true),
    new Question("DO YOU LIKE SHIVAM " , true)
  ]);
  String questionText;
  bool isCorrect;
  int questionNumber;
  bool overlayDisplay = false;

  @override
  void initState()
  {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer)
  {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState((){
      overlayDisplay = true;
    });

  }

  @override
  Widget build(BuildContext context)
  {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(// This is our main page
          children: <Widget>[
            new AnswerButton(true ,() => handleAnswer(true)), // TRUE BUTTOON
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false ,() => handleAnswer(false)) // FALSE BUTTON
          ],
        ),
        overlayDisplay == true ? new CorrectWrongOverlay(
          isCorrect,
            () {
              currentQuestion = quiz.nextQuestion;
              this.setState((){
                   overlayDisplay = false;
                   questionText = currentQuestion.question;
                   questionNumber = quiz.questionNumber;
              });
            }
        ) : new Container()
      ],
    );
  }
}