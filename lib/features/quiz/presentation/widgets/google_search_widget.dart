// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';

class GoogleSearchWidget extends StatefulWidget {
  @override
  _GoogleSearchWidgetState createState() => _GoogleSearchWidgetState();
}

class _GoogleSearchWidgetState extends State<GoogleSearchWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  SettingsBloc get settingsBloc => sl<SettingsBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: settingsBloc.state.theme.googleInputBackgroundColor,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search with Google",
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (_) => _googleSearch(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _googleSearch();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.search,
                        color: settingsBloc.state.theme.iconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _googleSearch() {
    html.window.location.href =
        "https://www.google.com/search?q=${_searchController.text}";
  }
}
