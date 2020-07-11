import 'package:learnenglish/features/quiz/data/models/language_model.dart';

const SERVER_FAILURE_MESSAGE = "Server has failed to fetch.";
const CACHE_FAILURE_MESSAGE = "Caching has gone wrong.";
const CONNECTION_FAILURE_MESSAGE = "You don't have an internet connection.";
const UNEXPECTED_FAILURE_MESSAGE = "Unexpected error.";
List<LanguageModel> languages = <LanguageModel>[
  LanguageModel(name: "Amharic", code: "am"),
  LanguageModel(name: "Arabic", code: "ar"),
  LanguageModel(name: "Basque", code: "eu"),
  LanguageModel(name: "Bengali", code: "bn"),
  LanguageModel(name: "English (UK)", code: "en-GB"),
  LanguageModel(name: "English (UK)", code: "en-GB"),
];
