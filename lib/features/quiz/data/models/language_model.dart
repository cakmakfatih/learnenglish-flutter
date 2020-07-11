import 'package:meta/meta.dart';

import '../../domain/entities/language.dart';

class LanguageModel extends Language {
  LanguageModel({
    @required String name,
    @required String code,
  }) : super(name: name, code: code);  

  factory LanguageModel.fromJson(Map jsonMap) {
    return LanguageModel(
      name: jsonMap["name"],
      code: jsonMap["code"],
    );
  }

  Map toJson() {
    return {
      "name": name,
      "code": code,
    };
  }
}
