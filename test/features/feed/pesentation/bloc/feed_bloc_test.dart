import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_app/features/feed/domain/usecases/fetch_post_use_case.dart';
import 'package:social_app/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:social_app/features/feed/presentation/bloc/feed/feed_event.dart';
import 'package:social_app/features/feed/presentation/bloc/feed/feed_state.dart';

import '../../../auth/data/repository/mock_post_repository.dart';

void main() {
  group('FeedBloc test', () {
    late FeedBloc feedBloc;
    late FeedBloc feedBlocWithError;
    setUp(() {
      feedBloc = FeedBloc(
        fetchPostsUseCase: FetchPostsUseCase(
          postRepository: MockPostRepository(),
        ),
      );
      feedBlocWithError = FeedBloc(
        fetchPostsUseCase: FetchPostsUseCase(
          postRepository: MockPostWithErrorrepository(),
        ),
      );
    });
    blocTest(
      'emit [feedLoading, FeedSucess] when posts are fetched sucessfully',
      build: () => feedBloc,
      act: (bloc) => bloc.add(FetchPostsRequested()),
      expect: () => [FeedLoading(), isA<FeedLoaded>()],
    );

    blocTest(
      'emit [feedLoading, FeedSucess] when loaded post failed',
      build: () => feedBlocWithError,
      act: (bloc) => bloc.add(FetchPostsRequested()),
      expect: () => [FeedLoading(), isA<FeedFailure>()],
    );
  });
}
