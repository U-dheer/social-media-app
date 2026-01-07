import 'package:social_app/features/feed/domain/entities/post_entity.dart';
import 'package:social_app/features/feed/domain/repository/post_repository.dart';

class MockPostRepository implements PostRepository {
  @override
  Future<List<PostEntity>> fetchPosts() async {
    return [
      PostEntity(
        userId: '123',
        username: 'fabrico',
        content: 'Hello world!',
        createdAt: DateTime.now(),
      ),
      PostEntity(
        userId: '13',
        username: 'fabrico00',
        content: 'Hello00 world!',
        createdAt: DateTime.now(),
      ),
      PostEntity(
        userId: '1234',
        username: 'uditha',
        content: 'it is what it is',
        createdAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<bool> createPost({required PostEntity post}) async {
    // Simulate a successful post creation
    return true;
  }
}

class MockPostWithErrorrepository implements PostRepository {
  @override
  Future<List<PostEntity>> fetchPosts() async {
    throw Exception('Repository error');
  }

  @override
  Future<bool> createPost({required PostEntity post}) async {
    throw Exception('Repository error');
  }
}
