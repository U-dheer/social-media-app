abstract class CreatePostEvent {}

class CreatePostRequested extends CreatePostEvent {
  final String username;
  final String content;
  final String? imageUrl;
  final String userId;

  CreatePostRequested({
    required this.username,
    required this.content,
    required this.userId,
    this.imageUrl,
  });
}
