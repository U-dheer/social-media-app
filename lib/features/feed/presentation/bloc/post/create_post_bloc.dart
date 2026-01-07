import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils.dart';
import 'package:social_app/features/feed/domain/usecases/create_post_use_case.dart';
import 'package:social_app/features/feed/presentation/bloc/post/create_post_event.dart';
import 'package:social_app/features/feed/presentation/bloc/post/create_posts_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostsState> {
  CreatePostUseCase createPostUseCase;

  CreatePostBloc({required this.createPostUseCase})
    : super(CreatePostInitial()) {
    on<CreatePostRequested>(_createPostRequested);
  }

  _createPostRequested(
    CreatePostRequested event,
    Emitter<CreatePostsState> emit,
  ) async {
    emit(CreatePostLoading());
    try {
      await createPostUseCase.call(
        userId: event.userId,
        username: event.username,
        content: event.content,
        imageUrl: event.imageUrl,
      );
    } catch (e) {
      emit(CreatePostFailure(messsage: formatError(e)));
    }
  }
}
