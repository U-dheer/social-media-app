import 'package:flutter_test/flutter_test.dart';
import 'package:social_app/features/feed/data/repository/mock_posts_repository.dart';
import 'package:social_app/features/feed/domain/usecases/create_post_use_case.dart';

void main() {
  group('createPostUseCase', () {
    late MockPostRepository mockPostRepository;
    late MockPostWithErrorrepository mockPostWithErrorrepository;

    setUp(() {
      mockPostRepository = MockPostRepository();
      mockPostWithErrorrepository = MockPostWithErrorrepository();
    });
    test('Should create a post successfully', () async {
      String userId = '1234';
      String username = 'testuser';
      String content = 'This is a test post';
      String? imageUrl = '';

      CreatePostUseCase createPostUseCase = CreatePostUseCase(
        postRepository: mockPostRepository,
      );
      final result = await createPostUseCase.call(
        userId: userId,
        username: username,
        content: content,
        imageUrl: imageUrl,
      );

      expect(result, isTrue);
    });

    test('Should return an error if username or content is empty', () async {
      String userId = '1234';
      String username = '';
      String content = '';
      String? imageUrl = '';

      CreatePostUseCase createPostUseCase = CreatePostUseCase(
        postRepository: mockPostRepository,
      );
      expect(
        () async => await createPostUseCase.call(
          userId: userId,
          username: username,
          content: content,
          imageUrl: imageUrl,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test(
      'Should return an error if there an error with the repository',
      () async {
        String userId = '1234';
        String username = 'fabrico';
        String content = 'best post ever';
        String? imageUrl = '';

        CreatePostUseCase createPostUseCase = CreatePostUseCase(
          postRepository: mockPostWithErrorrepository,
        );
        expect(
          () async => await createPostUseCase.call(
            userId: userId,
            username: username,
            content: content,
            imageUrl: imageUrl,
          ),
          throwsA(isA<Exception>()),
        );
      },
    );
  });
}
