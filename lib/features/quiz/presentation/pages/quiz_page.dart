import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoogleSearchWidget(),
            SizedBox(height: 20),
            buildState(),
          ],
        ),
      ),
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

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
