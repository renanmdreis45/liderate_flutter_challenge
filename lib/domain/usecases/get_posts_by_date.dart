import 'package:liderate_flutter_challenge/core/errors/exceptions.dart';
import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';
import 'package:liderate_flutter_challenge/domain/repositories/post_repository.dart';

class GetPostsByDate {
  final PostRepository repository;

  GetPostsByDate({required this.repository});

  Future<List<PostEntity>> execute(DateTime date) async {
    try {
      return await repository.getPostsByDate(date);
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException();
    }
  }
}
