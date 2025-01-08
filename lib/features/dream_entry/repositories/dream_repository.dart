import '../models/dream_entry_model.dart';

/// Repository interface for dream-related operations
abstract class DreamRepository {
  /// Saves a new dream entry
  Future<void> saveDream(DreamEntry dream);

  /// Updates an existing dream entry
  Future<void> updateDream(DreamEntry dream);

  /// Retrieves a dream by ID
  Future<DreamEntry?> getDream(String id);

  /// Retrieves all dreams for a user
  Future<List<DreamEntry>> getUserDreams(String userId);

  /// Updates the tags for a dream
  Future<void> updateDreamTags(String dreamId, List<String> tags);

  /// Updates the mood rating for a dream
  Future<void> updateDreamMoodRating(String dreamId, int rating);
}
