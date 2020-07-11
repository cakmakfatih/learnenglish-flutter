import 'package:flutter/material.dart';

import '../../domain/entities/language.dart';

class SelectLanguageWidget extends StatelessWidget {
  const SelectLanguageWidget({
    Key key,
    @required this.languages,
  }) : super(key: key);

  final List<Language> languages;

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 3,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Select Your Language",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0x99000000),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Material(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.filter_list),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Find",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Scrollbar(
                isAlwaysShown: true,
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    return _buildLanguage(languages[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1,
                      color: Colors.grey.shade200,
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

  Widget _buildLanguage(Language language) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: ListTile(
        onTap: () {},
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
}
