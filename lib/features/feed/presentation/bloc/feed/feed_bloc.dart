import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils.dart';
import 'package:social_app/features/feed/domain/usecases/fetch_post_use_case.dart';
import 'package:social_app/features/feed/presentation/bloc/feed/feed_event.dart';
import 'package:social_app/features/feed/presentation/bloc/feed/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FetchPostsUseCase fetchPostsUseCase;

  FeedBloc({required this.fetchPostsUseCase}) : super(FeedInitial()) {
    on<FetchPostsRequested>(_fetchPostsRequested);
  }

  _fetchPostsRequested(
    FetchPostsRequested event,
    Emitter<FeedState> emit,
  ) async {
    emit(FeedLoading());
    try {
      final posts = await fetchPostsUseCase.call();
      emit(FeedLoaded(posts: posts));
    } catch (e) {
      emit(FeedFailure(message: formatError(e)));
    }
  }
}
