import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/core/di/injection.dart';
import 'package:dream/features/dream_entry/services/openai_service.dart';
import 'package:injectable/injectable.dart';
import '../models/dream_entry_model.dart';

@singleton
class InterpretationService {
  final OpenAIService _openAIService;

  final FirebaseFirestore _firebaseFirestore = getIt<FirebaseFirestore>();

  InterpretationService(this._openAIService);

  Future<String> interpretDream(String dreamContent) async {
    try {
      final prompt = '''
Analyze the following dream and provide an interpretation:

$dreamContent

Please provide:
1. Key symbols and their meanings
2. Overall theme
3. Possible emotional significance
4. Potential life connections
''';

      //final interpretation =
      //await _openAIService.generateInterpretation(prompt);
      final interpretation =
          await _openAIService.generateMockInterpretation(dreamContent);
      return interpretation;
    } catch (e) {
      throw InterpretationException('Failed to interpret dream: $e');
    }
  }

  Future<void> saveDream(DreamEntry dream) async {
    try {
      final dreamData = dream.toJson();
      await _firebaseFirestore
          .collection('dreams')
          .doc(dream.id)
          .set(dreamData);
    } catch (e) {
      throw InterpretationException('Failed to save dream: $e');
    }
  }

  Future<void> updateDream(DreamEntry dream) async {
    try {
      final dreamData = dream.toJson();
      await _firebaseFirestore
          .collection('dreams')
          .doc(dream.id)
          .update(dreamData);
    } catch (e) {
      throw InterpretationException('Failed to update dream: $e');
    }
  }
}

class InterpretationException implements Exception {
  final String message;
  InterpretationException(this.message);
}
