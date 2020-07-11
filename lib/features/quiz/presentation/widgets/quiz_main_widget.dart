import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnenglish/features/quiz/domain/entities/question.dart';

import '../../../../injection_container.dart';
import '../bloc/quiz_bloc.dart';

class QuizMainWidget extends StatefulWidget {
  QuizMainWidget({Key key}) : super(key: key);

  @override
  _QuizMainWidgetState createState() => _QuizMainWidgetState();
}

class _QuizMainWidgetState extends State<QuizMainWidget> {
  QuizBloc get bloc => sl<QuizBloc>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(GetQuestionEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ((bloc.state as QuizMain).selectedAnswerIndex != null &&
            (bloc.state as QuizMain).isLoading == false) {
          bloc.add(GetQuestionEvent());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        height: 200,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: BlocBuilder<QuizBloc, QuizState>(
          bloc: bloc,
          builder: (BuildContext context, QuizState state) {
            if (!(state is QuizMain)) {
              return Container();
            }

            if ((state as QuizMain).isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if ((state as QuizMain).question == null) {
              return Container();
            }

            return buildQuestion((state as QuizMain).question);
          },
        ),
      ),
    );
  }

  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 22,
          alignment: Alignment.center,
          child: Text(
            question.word,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xffEF506C),
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var wordIndex = 0;
                wordIndex < question.words.length;
                wordIndex++) ...[
              buildOption(wordIndex, question.words[wordIndex]),
              if (wordIndex != question.words.length - 1) SizedBox(width: 5),
            ],
          ],
        ),
        SizedBox(height: 15),
        Expanded(child: Container()),
        if ((bloc.state as QuizMain).selectedAnswerIndex != null)
          Text(
            "click anywhere on the card for the next word",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0x99000000),
            ),
          ),
      ],
    );
  }

  Expanded buildOption(
    int answerIndex,
    String word,
  ) {
    final mainState = (bloc.state as QuizMain);
    bool isDisabled = mainState.selectedAnswerIndex != null;

    if (!isDisabled)
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: MaterialButton(
            height: 45,
            color: Colors.transparent,
            padding: EdgeInsets.all(0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                width: 1,
                color: Colors.grey.shade200,
              ),
            ),
            onPressed: () {
              bloc.add(SelectAnswerEvent(answerIndex: answerIndex));
            },
            child: Text(
              word,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );

    if (answerIndex == mainState.selectedAnswerIndex ||
        answerIndex == mainState.question.answer) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                width: 1,
                color: Colors.transparent,
              ),
              color: answerIndex == mainState.question.answer
                  ? Colors.green
                  : Colors.red,
            ),
            child: Center(
              child: Text(
                word,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 1,
              color: Colors.grey.shade200,
            ),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              word,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
