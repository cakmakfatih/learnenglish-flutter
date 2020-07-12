import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../bloc/quiz_bloc.dart';
import '../widgets/google_search_widget.dart';
import '../widgets/quiz_main_widget.dart';
import '../widgets/select_language_widget.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBloc get bloc => sl<QuizBloc>();
  SettingsBloc get settingsBloc => sl<SettingsBloc>();

  @override
  Widget build(BuildContext context) {
    if (bloc.state is QuizInitial) {
      bloc.add(SetStartPageEvent());
    }

    return Scaffold(
      body: Stack(
        children: [
          buildTopLeft(),
          buildTopRight(),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GoogleSearchWidget(),
                SizedBox(height: 20),
                buildState(),
                SizedBox(height: 10),
                buildBottom(),
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

  Widget buildBottom() {
    return BlocBuilder<QuizBloc, QuizState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is QuizMain && state.selectedAnswerIndex != null) {
          return Text(
            state.selectedAnswerIndex >= 0
                ? "click anywhere on the card for the next word"
                : "",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: settingsBloc.state.theme.subTextColor,
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget buildTopRight() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: settingsBloc,
      builder: (BuildContext context, SettingsState state) {
        return Positioned(
          right: 30,
          top: 10,
          child: Row(
            children: [
              Text("Dark Theme"),
              Switch(
                value: state.isDark,
                onChanged: (bool value) {
                  settingsBloc.add(SettingsSwitchThemeEvent());
                },
              ),
            ],
          ),
        );
      },
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
