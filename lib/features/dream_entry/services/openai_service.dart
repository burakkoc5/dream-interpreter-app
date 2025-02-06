import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../exceptions/interpretation_exception.dart';
import 'package:dream/config/language/language_cubit.dart';

/// Service responsible for interacting with OpenAI API
@injectable
class OpenAIService {
  final String apiKey;
  final String model = 'gpt-4';
  final String baseUrl = 'https://api.openai.com/v1/chat/completions';
  final LanguageCubit _languageCubit;

  OpenAIService(this._languageCubit)
      : apiKey = dotenv.env['OPEN_API_KEY'] ?? '';

  /// Generates dream interpretation using OpenAI API
  Future<String> generateInterpretation(
    String dreamContent, {
    String? gender,
    String? horoscope,
    String? occupation,
    String? relationshipStatus,
    DateTime? birthDate,
    List<String>? interests,
  }) async {
    try {
      final currentLanguage = _languageCubit.state;
      if (apiKey.isEmpty) {
        throw InterpretationException(
            'OpenAI API key is not configured. Please check your .env file.');
      }

      debugPrint(
          'Making API request with key starting with: ${apiKey.substring(0, 4)}...');

      // Build personal context string
      final List<String> personalContext = [];
      if (gender != null) personalContext.add('Gender: $gender');
      if (horoscope != null) personalContext.add('Zodiac Sign: $horoscope');
      if (occupation != null) personalContext.add('Occupation: $occupation');
      if (relationshipStatus != null) {
        personalContext.add('Relationship Status: $relationshipStatus');
      }
      if (birthDate != null) {
        final age = DateTime.now().difference(birthDate).inDays ~/ 365;
        personalContext.add('Age: $age years old');
      }
      if (interests != null && interests.isNotEmpty) {
        personalContext.add('Interests: ${interests.join(", ")}');
      }

      final requestBody = jsonEncode({
        'model': model,
        'messages': [
          {
            'role': 'system',
            'content':
                '''IMPORTANT: You must provide your entire response in ${currentLanguage.languageCode} language.

            You are a wise and empathetic dream interpreter who provides personalized dream 
            interpretations with a storyteller's touch. Your interpretations should flow 
            naturally like a conversation, weaving together symbols, meanings, and personal 
            context into an engaging narrative.
            
            Maintain a warm, insightful tone throughout the interpretation, as if you're having 
            a deep, meaningful conversation with the dreamer. After the main interpretation, 
            naturally transition into suggesting practical insights or actions while maintaining 
            the same engaging tone.

            Remember: The entire response MUST be in ${currentLanguage.languageCode} language.'''
          },
          {
            'role': 'user',
            'content': '''[Response language: ${currentLanguage.languageCode}]

            Personal Context:
            ${personalContext.join('\n')}
            
            Please interpret this dream with deep insight and personal connection:
            
            Dream: $dreamContent
            
            Weave together the symbolic meanings, personal circumstances, and potential life 
            connections into a flowing narrative. Then, naturally transition into suggesting 
            some practical insights or actions that might be helpful for the dreamer.

            Important: Provide your complete response in ${currentLanguage.languageCode} language.
            '''
          }
        ],
        'temperature': 0.7,
      });

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $apiKey',
          HttpHeaders.acceptCharsetHeader: 'utf-8',
        },
        body: requestBody,
      );

      debugPrint('API Response Status Code: ${response.statusCode}');
      debugPrint('API Response Body: ${utf8.decode(response.bodyBytes)}');

      if (response.statusCode == 401) {
        throw InterpretationException(
            'Authentication failed: Please check if your OpenAI API key is valid and properly configured in .env file.');
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'];
      } else {
        throw InterpretationException(
            'API Error: ${response.statusCode} - ${utf8.decode(response.bodyBytes)}');
      }
    } catch (e) {
      throw InterpretationException('Failed to generate interpretation: $e');
    }
  }
}
