import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/language.dart';
import '../models/question_model.dart';

abstract class QuizRemoteDataSource {
  Future<QuestionModel> getQuestion(Language language);
  Future<String> getTextToSpeechAudio(String text);
}

const API_URL = "learn-english-ffhood.herokuapp.com";

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final http.Client client;

  QuizRemoteDataSourceImpl({@required this.client});

  @override
  Future<QuestionModel> getQuestion(Language language) async {
    final uri = Uri.https(API_URL, '/api/v1/prepare/${language.code}');

    final response = await client.get(uri);

    if (response.statusCode >= 300 || response.statusCode < 200) {
      throw ServerException();
    }

    final body = json.decode(response.body);

    return QuestionModel.fromJson(body);
  }

  @override
  Future<String> getTextToSpeechAudio(String text) async {
    final uri = Uri.https(API_URL, '/api/v1/prepare/speech/$text');

    final response = await client.get(uri);

    if (response.statusCode >= 300 || response.statusCode < 200) {
      throw ServerException();
    }

    final body = json.decode(response.body);

    return body["url"];
  }
}
