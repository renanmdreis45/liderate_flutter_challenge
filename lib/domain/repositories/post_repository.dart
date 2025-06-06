import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts();
  Future<List<PostEntity>> getPostsByDate(DateTime date);
  Future<void> savePost(PostEntity post);
  Future<DateTime> getNextAvailableTime();
}
