import 'package:flutter/material.dart';
import 'dart:html' as html;

class GoogleSearchWidget extends StatefulWidget {
  @override
  _GoogleSearchWidgetState createState() => _GoogleSearchWidgetState();
}

class _GoogleSearchWidgetState extends State<GoogleSearchWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Google",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 40,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey.shade100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
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
    html.window.location.href = "https://www.google.com/search?q=${_searchController.text}";
  }
}
