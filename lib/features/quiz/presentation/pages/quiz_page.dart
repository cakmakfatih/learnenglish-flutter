import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnenglish/features/quiz/presentation/widgets/quiz_main_widget.dart';

import '../../../../injection_container.dart';
import '../bloc/quiz_bloc.dart';
import '../widgets/google_search_widget.dart';
import '../widgets/select_language_widget.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBloc get bloc => sl<QuizBloc>();

  @override
  Widget build(BuildContext context) {
    bloc.add(SetStartPageEvent());

    return Scaffold(
      body: Stack(
        children: [
          buildTopLeft(),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleSearchWidget(),
                SizedBox(height: 20),
                buildState(),
                SizedBox(height: 20),
                Image.network(
                  'images/logo.png',
                  width: 40,
                ),
                SizedBox(height: 10),
                Text(
                  "LEARN ENGLISH",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopLeft() {
    return BlocBuilder<QuizBloc, QuizState>(
      bloc: bloc,
      builder: (BuildContext context, QuizState state) {
        if (state is QuizMain) {
          return Positioned(
            left: 30,
            top: 10,
            child: DropdownButton(
              value: state.language,
              onChanged: (value) {
                if (value.code != state.language.code)
                  bloc.add(SetLanguageFromDropdownEvent(language: value));
              },
              items: [
                for (int languageIndex = 0;
                    languageIndex < state.languages.length;
                    languageIndex++)
                  DropdownMenuItem(
                    key: ValueKey(languageIndex),
                    child: Text(
                      state.languages[languageIndex].name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: state.languages[languageIndex],
                  ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildState() {
    return BlocBuilder<QuizBloc, QuizState>(
      bloc: bloc,
      builder: (BuildContext context, QuizState state) {
        if (state is QuizSelectLanguage)
          return SelectLanguageWidget(
            languages: state.languages,
          );
        else if (state is QuizMain) {
          return QuizMainWidget();
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
