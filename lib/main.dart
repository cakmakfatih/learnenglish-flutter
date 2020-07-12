import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/quiz/presentation/bloc/quiz_bloc.dart';
import 'features/quiz/presentation/pages/quiz_page.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(App());
}

TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.poppins(
      fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.poppins(
      fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.poppins(
    fontSize: 23,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: 0.15,
  ),
  headline6: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(
      fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    sl<SettingsBloc>().add(SettingsSetInitialThemeEvent());

    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => sl<SettingsBloc>(),
        ),
        BlocProvider<QuizBloc>(
          create: (context) => sl<QuizBloc>(),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        bloc: sl<SettingsBloc>(),
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Learn English',
            home: QuizPage(),
            theme: ThemeData(
              canvasColor: state.theme.canvasColor,
              textTheme: textTheme,
              brightness: state.isDark ? Brightness.dark : Brightness.light,
            ),
          );
        },
      ),
    );
  }
}
