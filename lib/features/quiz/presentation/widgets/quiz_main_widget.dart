import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../domain/entities/question.dart';
import '../bloc/quiz_bloc.dart';

class QuizMainWidget extends StatefulWidget {
  QuizMainWidget({Key key}) : super(key: key);

  @override
  _QuizMainWidgetState createState() => _QuizMainWidgetState();
}

class _QuizMainWidgetState extends State<QuizMainWidget> {
  QuizBloc get bloc => sl<QuizBloc>();
  SettingsBloc get settingsBloc => sl<SettingsBloc>();

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
        if ((bloc.state as QuizMain).selectedAnswerIndex != -1 &&
            (bloc.state as QuizMain).isLoading == false) {
          bloc.add(GetQuestionEvent());
        }
      },
      child: Container(
        width: 500,
        height: 160,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: settingsBloc.state.theme.cardBackgroundColor,
          boxShadow: settingsBloc.state.theme.cardShadows,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
            ),
            Container(
              height: 25,
              alignment: Alignment.center,
              child: Text(
                question.word,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: settingsBloc.state.theme.mainTextColor,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 50,
              alignment: Alignment.centerRight,
              child: Material(
                color: settingsBloc.state.theme.speechButtonBackgroundColor,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.volume_up,
                      color: (bloc.state as QuizMain).selectedAnswerIndex < 0
                          ? settingsBloc
                              .state.theme.speechButtonBackgroundDeactiveColor
                          : settingsBloc
                              .state.theme.speechButtonBackgroundActiveColor,
                    ),
                  ),
                  onTap: (bloc.state as QuizMain).selectedAnswerIndex < 0
                      ? null
                      : () {
                          bloc.add(PlayTextEvent());
                        },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var wordIndex = 0;
                wordIndex < question.words.length;
                wordIndex++) ...[
              buildOption(wordIndex, question.words[wordIndex]),
              if (wordIndex != question.words.length - 1) SizedBox(width: 10),
            ],
          ],
        ),
      ],
    );
  }

  Expanded buildOption(
    int answerIndex,
    String word,
  ) {
    final mainState = (bloc.state as QuizMain);
    bool isDisabled = mainState.selectedAnswerIndex >= 0;

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
                color: settingsBloc.state.theme.optionBorderColor,
              ),
            ),
            onPressed: () {
              bloc.add(SelectAnswerEvent(answerIndex: answerIndex));
            },
            child: Text(
              word,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: settingsBloc.state.theme.mainTextColor,
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
                  ? settingsBloc.state.theme.correctAnswerButtonBackgroundColor
                  : settingsBloc.state.theme.wrongAnswerButtonBackgroundColor,
            ),
            child: Center(
              child: Text(
                word,
                style: Theme.of(context).textTheme.button.copyWith(
                      fontWeight: FontWeight.w500,
                      color: settingsBloc.state.theme.oppositeTextColor,
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
              color: settingsBloc.state.theme.optionBorderColor,
            ),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              word,
              style: Theme.of(context).textTheme.button.copyWith(
                    fontWeight: FontWeight.w500,
                    color: settingsBloc.state.theme.mainTextColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
