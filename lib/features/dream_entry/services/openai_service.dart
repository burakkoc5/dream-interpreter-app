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
  Future<String> generateInterpretation(String dreamContent) async {
    try {
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
              'content': 'You are a dream interpretation expert.'
            },
            {
              'role': 'user',
              'content': '''
              Analyze the following dream and provide an interpretation:
              
              Dream: $dreamContent
              
              Please provide:
              1. Key symbols and their meanings
              2. Overall interpretation
              3. Potential life connections
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

  Future<String> generateMockInterpretation(String dreamContent) async {
    return Future.delayed(Duration(seconds: 2), () {
      return '''
      Key symbols: Water, boat, lighthouse
      Overall interpretation: Dream suggests you are navigating through a difficult situation in your life. The water represents your emotions, the boat is your journey, and the lighthouse is a symbol of hope and guidance.
      Potential life connections: The dream may be reflecting your current struggles and the need for direction and support.
      ''';
    });
  }
}
