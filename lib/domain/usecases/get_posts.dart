import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';
import 'package:liderate_flutter_challenge/domain/repositories/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts({required this.repository});

  Future<List<PostEntity>> execute() async {
    return await repository.getPosts();
  }
}
