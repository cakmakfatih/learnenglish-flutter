import 'package:flutter/material.dart';

class LeTheme {
  final Color canvasColor;
  final Color mainTextColor;
  final Color subTextColor;
  final Color cardBackgroundColor;
  final List<BoxShadow> cardShadows;
  final Color googleInputBackgroundColor;
  final Color optionBorderColor;
  final Color speechButtonBackgroundActiveColor;
  final Color speechButtonBackgroundDeactiveColor;
  final Color correctAnswerButtonBackgroundColor;
  final Color wrongAnswerButtonBackgroundColor;
  final Color oppositeTextColor;
  final Color seperatorColor;
  final Color iconColor;
  final Color speechButtonBackgroundColor;

  LeTheme({
    @required this.canvasColor,
    @required this.mainTextColor,
    @required this.subTextColor,
    @required this.cardBackgroundColor,
    @required this.cardShadows,
    @required this.googleInputBackgroundColor,
    @required this.optionBorderColor,
    @required this.speechButtonBackgroundActiveColor,
    @required this.speechButtonBackgroundDeactiveColor,
    @required this.correctAnswerButtonBackgroundColor,
    @required this.wrongAnswerButtonBackgroundColor,
    @required this.oppositeTextColor,
    @required this.seperatorColor,
    @required this.iconColor,
    @required this.speechButtonBackgroundColor,
  });

  factory LeTheme.light() {
    return LeTheme(
      canvasColor: Colors.white,
      mainTextColor: Colors.black87,
      subTextColor: Colors.black54,
      cardBackgroundColor: Colors.white,
      cardShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 2,
          offset: Offset(0, 1), // changes position of shadow
        )
      ],
      googleInputBackgroundColor: Colors.grey.shade100,
      optionBorderColor: Colors.grey.shade200,
      speechButtonBackgroundActiveColor: Color(0xff60B1E7),
      speechButtonBackgroundDeactiveColor: Colors.grey.shade200,
      correctAnswerButtonBackgroundColor: Color(0xff51CB76),
      wrongAnswerButtonBackgroundColor: Color(0xffEF506C),
      oppositeTextColor: Colors.white,
      seperatorColor: Colors.grey.shade200,
      iconColor: Colors.black,
      speechButtonBackgroundColor: Colors.transparent,
    );
  }

  factory LeTheme.dark() {
    return LeTheme(
      canvasColor: Color(0xff171717),
      mainTextColor: Colors.white70,
      subTextColor: Colors.white54,
      cardBackgroundColor: Color(0xff212121),
      cardShadows: [
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 2,
          offset: Offset(0, 1), // changes position of shadow
        )
      ],
      googleInputBackgroundColor: Color(0xff484848),
      optionBorderColor: Colors.white10,
      speechButtonBackgroundColor: Colors.transparent,
      speechButtonBackgroundActiveColor: Color(0xff60B1E7),
      speechButtonBackgroundDeactiveColor: Colors.grey.shade800,
      correctAnswerButtonBackgroundColor: Color(0xff51CB76),
      wrongAnswerButtonBackgroundColor: Color(0xffEF506C),
      oppositeTextColor: Colors.white,
      seperatorColor: Colors.white10,
      iconColor: Colors.white,
    );
  }
}
