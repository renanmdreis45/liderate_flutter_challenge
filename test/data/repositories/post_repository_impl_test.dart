import 'package:flutter_test/flutter_test.dart';
import 'package:liderate_flutter_challenge/core/errors/exceptions.dart';
import 'package:liderate_flutter_challenge/data/repositories/post_repository_impl.dart';
import 'package:liderate_flutter_challenge/domain/entities/post_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late PostRepositoryImpl repository;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repository = PostRepositoryImpl();
  });

  test('Deve retornar lista vazia se não houver posts salvos', () async {
    final posts = await repository.getPosts();

    expect(posts, isEmpty);
  });

  test('Deve salvar um post e recuperá-lo corretamente', () async {
    final post = PostEntity(
      id: '1',
      title: 'Teste',
      description: 'Descrição de teste',
      scheduledDate: DateTime(2025, 6, 6, 10, 0),
    );

    await repository.savePost(post);

    final posts = await repository.getPosts();

    expect(posts.length, 1);
    expect(posts.first.title, 'Teste');
    expect(posts.first.description, 'Descrição de teste');
    expect(posts.first.scheduledDate, post.scheduledDate);
  });

  test(
      'Deve lançar ValidationException se tentar salvar um post no mesmo horário',
      () async {
    final dateTime = DateTime(2025, 6, 6, 10, 0);

    final post1 = PostEntity(
      id: '1',
      title: 'Post 1',
      description: 'Desc 1',
      scheduledDate: dateTime,
    );

    final post2 = PostEntity(
      id: '2',
      title: 'Post 2',
      description: 'Desc 2',
      scheduledDate: dateTime,
    );

    await repository.savePost(post1);

    expect(() async => await repository.savePost(post2),
        throwsA(isA<ValidationException>()));
  });

  test('Deve retornar posts de uma data específica', () async {
    final date1 = DateTime(2025, 6, 6);
    final date2 = DateTime(2025, 6, 7);

    final post1 = PostEntity(
      id: '1',
      title: 'Post 1',
      description: 'Desc 1',
      scheduledDate: date1.add(const Duration(hours: 10)),
    );

    final post2 = PostEntity(
      id: '2',
      title: 'Post 2',
      description: 'Desc 2',
      scheduledDate: date2.add(const Duration(hours: 15)),
    );

    await repository.savePost(post1);
    await repository.savePost(post2);

    final postsForDate1 = await repository.getPostsByDate(date1);
    final postsForDate2 = await repository.getPostsByDate(date2);

    expect(postsForDate1.length, 1);
    expect(postsForDate1.first.id, '1');

    expect(postsForDate2.length, 1);
    expect(postsForDate2.first.id, '2');
  });
}
