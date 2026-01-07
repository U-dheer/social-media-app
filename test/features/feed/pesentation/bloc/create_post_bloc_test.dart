import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_app/features/feed/domain/usecases/create_post_use_case.dart';
import 'package:social_app/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:social_app/features/feed/presentation/bloc/post/create_post_event.dart';
import 'package:social_app/features/feed/presentation/bloc/post/create_posts_state.dart';

import '../../../auth/data/repository/mock_post_repository.dart';

void main() {
  group('FeedBloc test', () {
    late CreatePostBloc createPostBloc;
    late CreatePostBloc createPostBlocWithError;
    setUp(() {
      createPostBloc = CreatePostBloc(
        createPostUseCase: CreatePostUseCase(
          postRepository: MockPostRepository(),
        ),
      );
      createPostBlocWithError = CreatePostBloc(
        createPostUseCase: CreatePostUseCase(
          postRepository: MockPostWithErrorrepository(),
        ),
      );
    });
    blocTest(
      'emit [CreatePostLoading, CreatePostSuccess] when posts are created successfully',
      build: () => createPostBloc,
      act: (bloc) => bloc.add(
        CreatePostRequested(
          userId: '1234',
          username: 'testuser',
          content: 'This is a test post',
          imageUrl: '',
        ),
      ),
      expect: () => [CreatePostLoading(), isA<CreatePostSuccess>()],
    );

    blocTest(
      'emit [CreatePostLoading, CreatePostFailure] when loaded post failed',
      build: () => createPostBlocWithError,
      act: (bloc) => bloc.add(
        CreatePostRequested(
          userId: '1234',
          username: 'testuser',
          content: 'This is a test post',
          imageUrl: '',
        ),
      ),
      expect: () => [CreatePostLoading(), isA<CreatePostFailure>()],
    );
  });
}
