import 'dart:convert';

import 'package:learnenglish/core/error/exceptions.dart';
import 'package:learnenglish/features/quiz/data/models/question_model.dart';
import 'package:http/http.dart' as http;
import 'package:learnenglish/features/quiz/domain/entities/language.dart';
import 'package:meta/meta.dart';

abstract class QuizRemoteDataSource {
  Future<QuestionModel> getQuestion(Language language);
}

const API_URL = "localhost:5000";

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final http.Client client;

  QuizRemoteDataSourceImpl({@required this.client});

  @override
  Future<QuestionModel> getQuestion(Language language) async {
    final uri = Uri.http(API_URL, '/api/v1/prepare/${language.code}');

    final response = await client.get(uri);

    if (response.statusCode >= 300 || response.statusCode < 200) {
      throw ServerException();
    }

    final body = json.decode(response.body);

    return QuestionModel.fromJson(body);
  }
}
