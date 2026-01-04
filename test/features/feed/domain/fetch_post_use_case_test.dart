import 'package:flutter_test/flutter_test.dart';
import 'package:social_app/features/feed/domain/entities/post_entity.dart';
import 'package:social_app/features/feed/domain/usecases/fetch_post_use_case.dart';

import '../../auth/data/repository/mock_post_repository.dart';

void main() {
  MockPostRepository mockPostRepository = MockPostRepository();
  FetchPostsUseCase fetchPostsUseCase = FetchPostsUseCase(
    postRepository: mockPostRepository,
  );
  group('FetchFeedUseCase test', () {
    test('Should return list of posts', () async {
      final results = await fetchPostsUseCase.call();
      expect(results, isA<List<PostEntity>>());
      expect(results.length, greaterThan(0));
    });
  });
}
