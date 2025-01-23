import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dream/core/di/injection.dart';
import 'package:dream/features/dream_entry/services/openai_service.dart';
import 'package:injectable/injectable.dart';
import '../models/dream_entry_model.dart';
import 'package:dream/features/profile/application/profile_cubit.dart';

@singleton
class InterpretationService {
  final OpenAIService _openAIService;
  final FirebaseFirestore _firebaseFirestore = getIt<FirebaseFirestore>();

  InterpretationService(this._openAIService);

  Future<String> interpretDream(String dreamContent) async {
    try {
      final profile = getIt<ProfileCubit>().state.profile;

      final interpretation = await _openAIService.generateMockInterpretation(
        dreamContent,
        gender: profile?.gender,
        horoscope: profile?.horoscope,
        occupation: profile?.occupation,
        birthDate: profile?.birthDate,
        interests: profile?.interests,
      );
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
