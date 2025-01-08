import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dream_entry_model.dart';
import 'dart:convert';

/// Service responsible for temporary local storage operations
@singleton
class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  /// Saves a dream entry draft temporarily
  Future<void> saveDraft(DreamEntry draft) async {
    try {
      await _prefs.setString('dream_draft', jsonEncode(draft.toJson()));
    } catch (e) {
      throw LocalStorageException('Failed to save draft: $e');
    }
  }

  /// Retrieves saved draft
  Future<DreamEntry?> getDraft() async {
    try {
      final draft = _prefs.getString('dream_draft');
      if (draft == null) return null;
      return DreamEntry.fromJson(jsonDecode(draft));
    } catch (e) {
      throw LocalStorageException('Failed to get draft: $e');
    }
  }

  /// Clears the saved draft
  Future<void> clearDraft() async {
    try {
      await _prefs.remove('dream_draft');
    } catch (e) {
      throw LocalStorageException('Failed to clear draft: $e');
    }
  }
}

class LocalStorageException implements Exception {
  final String message;
  LocalStorageException(this.message);
}
