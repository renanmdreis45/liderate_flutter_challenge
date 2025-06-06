import 'package:liderate_flutter_challenge/core/errors/exceptions.dart';
import 'package:liderate_flutter_challenge/domain/repositories/post_repository.dart';

class GetNextAvailableTime {
  final PostRepository repository;

  GetNextAvailableTime({required this.repository});

  Future<DateTime> execute() async {
    try {
      final now = DateTime.now();
      final todayPosts = await repository.getPostsByDate(now);

      if (todayPosts.isEmpty) {
        return now.add(const Duration(hours: 1));
      }

      todayPosts.sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));

      final lastPost = todayPosts.last;

      return lastPost.scheduledDate.add(const Duration(minutes: 30));
    } on CacheException {
      rethrow;
    } catch (e) {
      throw ScheduleException('Failed to calculate available time');
    }
  }
}

class ScheduleException implements Exception {
  final String message;
  ScheduleException(this.message);
}
