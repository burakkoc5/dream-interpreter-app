import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../exceptions/interpretation_exception.dart';

/// Service responsible for interacting with OpenAI API
@injectable
class OpenAIService {
  final String apiKey;
  final String model = 'gpt-4';
  final String baseUrl = 'https://api.openai.com/v1/chat/completions';

  OpenAIService() : apiKey = '';

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
      // Build personal context string
      final List<String> personalContext = [];
      if (gender != null) personalContext.add('Gender: $gender');
      if (horoscope != null) personalContext.add('Zodiac Sign: $horoscope');
      if (occupation != null) personalContext.add('Occupation: $occupation');
      if (relationshipStatus != null)
        personalContext.add('Relationship Status: $relationshipStatus');
      if (birthDate != null) {
        final age = DateTime.now().difference(birthDate).inDays ~/ 365;
        personalContext.add('Age: $age years old');
      }
      if (interests != null && interests.isNotEmpty) {
        personalContext.add('Interests: ${interests.join(", ")}');
      }

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': model,
          'messages': [
            {
              'role': 'system',
              'content':
                  '''You are a dream interpretation expert who provides personalized interpretations based on the dreamer's personal context.
              Consider how their personal circumstances, life stage, and interests might influence the dream's meaning.'''
            },
            {
              'role': 'user',
              'content': '''
              Personal Context:
              ${personalContext.join('\n')}
              
              Analyze the following dream and provide a personalized interpretation:
              
              Dream: $dreamContent
              
              Please provide:
              1. Key symbols and their meanings (considering personal context)
              2. Overall interpretation (tailored to the individual's circumstances)
              3. Potential life connections (relating to their current life situation)
              4. Actionable insights (based on their interests and life stage)
              '''
            }
          ],
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw InterpretationException(
            'API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw InterpretationException('Failed to generate interpretation: $e');
    }
  }

  Future<String> generateMockInterpretation(
    String dreamContent, {
    String? gender,
    String? horoscope,
    String? occupation,
    String? relationshipStatus,
    DateTime? birthDate,
    List<String>? interests,
  }) async {
    return Future.delayed(Duration(seconds: 2), () {
      return '''
      Key symbols: Water, boat, lighthouse (interpreted in context of ${occupation ?? 'your'} career journey)
      Overall interpretation: Given your ${relationshipStatus ?? 'current'} status and interest in ${interests?.firstOrNull ?? 'personal growth'}, this dream suggests you are navigating through a significant life transition.
      Potential life connections: As a ${horoscope ?? 'person'} in ${occupation ?? 'your field'}, the dream may reflect your professional aspirations and emotional journey.
      Actionable insights: Consider exploring ${interests?.firstOrNull ?? 'meditation'} to help navigate this period of change.
      ''';
    });
  }
}
