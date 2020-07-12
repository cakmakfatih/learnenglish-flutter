import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../domain/entities/language.dart';
import '../bloc/quiz_bloc.dart';

class SelectLanguageWidget extends StatefulWidget {
  const SelectLanguageWidget({
    Key key,
    @required this.languages,
  }) : super(key: key);

  final List<Language> languages;

  @override
  _SelectLanguageWidgetState createState() => _SelectLanguageWidgetState();
}

class _SelectLanguageWidgetState extends State<SelectLanguageWidget> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _filterTextController = TextEditingController();

  QuizBloc get bloc => sl<QuizBloc>();
  SettingsBloc get settingsBloc => sl<SettingsBloc>();

  String _filterText = "";
  List<Language> get _filteredLanguages =>
      widget.languages.where(_filterLanguage).toList();

  bool _filterLanguage(Language language) {
    return language.name.toLowerCase().contains(_filterText.toLowerCase()) ||
        language.code.toLowerCase().contains(_filterText.toLowerCase());
  }

  @override
  void initState() {
    super.initState();
    _filterTextController.addListener(_filterTextOnChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _filterTextController.dispose();
  }

  void _filterTextOnChanged() {
    setState(() {
      _filterText = _filterTextController.text;
    });
  }

  Widget _buildLanguage(int languageIndex) {
    Language language = _filteredLanguages[languageIndex];

    return Container(
      margin: EdgeInsets.only(right: 10),
      child: ListTile(
        key: ValueKey(languageIndex),
        onTap: () {
          bloc.add(SetLanguageEvent(language: language));
        },
        title: Text(
          language.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: settingsBloc.state.theme.cardBackgroundColor,
        boxShadow: settingsBloc.state.theme.cardShadows,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Select Your Language",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: settingsBloc.state.theme.mainTextColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Material(
            color: settingsBloc.state.theme.googleInputBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _filterTextController,
                decoration: InputDecoration(
                  hintText: "Find a language",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Material(
              color: settingsBloc.state.theme.cardBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: _filteredLanguages.length,
                  itemBuilder: (context, index) {
                    return _buildLanguage(index);
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1,
                      color: settingsBloc.state.theme.seperatorColor,
                      margin: EdgeInsets.only(right: 10),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
