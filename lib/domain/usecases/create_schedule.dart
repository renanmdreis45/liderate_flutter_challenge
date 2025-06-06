import 'package:liderate_flutter_challenge/core/errors/exceptions.dart';
import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';
import 'package:liderate_flutter_challenge/domain/repositories/post_repository.dart';

class CreateSchedule {
  final PostRepository repository;

  CreateSchedule({required this.repository});

  Future<void> execute(PostEntity post) async {
    try {
      if (!post.isValid()) {
        throw ValidationException('Dados de postagem inválidos');
      }
      await repository.savePost(post);
    } on ValidationException {
      rethrow;
    } catch (e) {
      throw CacheException();
    }
  }
}
