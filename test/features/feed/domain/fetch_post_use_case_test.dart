import 'package:flutter_test/flutter_test.dart';
import 'package:social_app/features/feed/domain/entities/post_entity.dart';
import 'package:social_app/features/feed/domain/usecases/fetch_post_use_case.dart';

import '../../auth/data/repository/mock_post_repository.dart';

void main() {
  group('FetchFeedUseCase test', () {
    late MockPostRepository mockPostRepository;
    late MockPostWithErrorrepository mockPostWithErrorrepository;

    setUp(() {
      mockPostRepository = MockPostRepository();
      mockPostWithErrorrepository = MockPostWithErrorrepository();
    });

    test('Should return list of posts', () async {
      FetchPostsUseCase fetchPostsUseCase = FetchPostsUseCase(
        postRepository: mockPostRepository,
      );
      final results = await fetchPostsUseCase.call();
      expect(results, isA<List<PostEntity>>());
      expect(results.length, greaterThan(0));
    });

    test('Should return an error if repository is compromised', () async {
      FetchPostsUseCase fetchPostsUseCase = FetchPostsUseCase(
        postRepository: mockPostWithErrorrepository,
      );
      expect(
        () async => await fetchPostsUseCase.call(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
