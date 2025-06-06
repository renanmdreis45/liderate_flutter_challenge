import 'dart:convert';

import 'package:liderate_flutter_challenge/core/constants/app_constants.dart';
import 'package:liderate_flutter_challenge/core/errors/exceptions.dart';
import 'package:liderate_flutter_challenge/data/models/post_model.dart';
import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';
import 'package:liderate_flutter_challenge/domain/repositories/post_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepositoryImpl implements PostRepository {
  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(AppConstants.postsStorageKey);

      if (jsonString == null) return [];

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((json) => PostModel.fromMap(json).toEntity())
          .toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> savePost(PostEntity post) async {
    try {
      if (await hasPostAtTime(post.scheduledDate)) {
        throw ValidationException(
            'Já existe uma postagem agendada neste horário ou em um intervalo de 30 minutos antes ou depois deste horário');
      }

      final prefs = await SharedPreferences.getInstance();
      final posts = await getPosts();
      posts.add(post);

      await _saveAllPosts(posts, prefs);
    } on ValidationException {
      rethrow;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<PostEntity>> getPostsByDate(DateTime date) async {
    final allPosts = await getPosts();
    return allPosts
        .where((post) => _isSameDate(post.scheduledDate, date))
        .toList();
  }

  @override
  Future<DateTime> getNextAvailableTime() async {
    final now = DateTime.now();
    final todayPosts = await getPostsByDate(now);

    if (todayPosts.isEmpty) return now.add(const Duration(hours: 1));

    final lastPostTime = todayPosts.last.scheduledDate;
    return lastPostTime.add(const Duration(minutes: 30));
  }

  Future<bool> hasPostAtTime(DateTime dateTime) async {
    final posts = await getPosts();
    return posts.any((post) =>
        post.scheduledDate.difference(dateTime).abs() <
        const Duration(minutes: 30));
  }

  Future<void> _saveAllPosts(
      List<PostEntity> posts, SharedPreferences prefs) async {
    final jsonList =
        posts.map((post) => PostModel.fromEntity(post).toMap()).toList();
    await prefs.setString(AppConstants.postsStorageKey, json.encode(jsonList));
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
