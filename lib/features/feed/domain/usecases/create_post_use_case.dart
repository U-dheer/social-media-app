import 'package:social_app/features/feed/domain/entities/post_entity.dart';
import 'package:social_app/features/feed/domain/repository/post_repository.dart';

class CreatePostUseCase {
  final PostRepository postRepository;
  CreatePostUseCase({required this.postRepository});

  Future<bool> call({
    required String userId,
    required String username,
    required String content,
    String? imageUrl,
  }) async {
    final post = PostEntity(
      userId: userId,
      username: username,
      content: content,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
      likesCount: 0,
      commentsCount: 0,
      repostsCount: 0,
    );
    final result = await postRepository.createPost(post: post);
    return result;
  }
}
