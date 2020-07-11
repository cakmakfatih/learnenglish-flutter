import 'package:flutter/material.dart';

import 'features/quiz/presentation/pages/quiz_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn English',
      home: QuizPage(),
      theme: ThemeData(
        canvasColor: Colors.white,
      ),
    );
  }
}
