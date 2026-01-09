class PostEntity {
  final String? id;
  final String userId;
  final String username;
  final String content;
  final DateTime createdAt;
  final int? likesCount;
  final int? commentsCount;
  final int? repostsCount;
  final String? imageUrl;

  PostEntity({
    this.id,
    required this.userId,
    required this.username,
    required this.content,
    required this.createdAt,
    this.likesCount,
    this.commentsCount,
    this.repostsCount,
    this.imageUrl,
  }) {
    if (username.trim().isEmpty) {
      throw Exception("Username cannot be empty");
    }
    if (content.trim().isEmpty) {
      throw Exception("Content cannot be empty");
    }
  }

  //serilization layers //
  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      username: json['username'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      likesCount: json['likes_count'] as int?,
      commentsCount: json['comments_count'] as int?,
      repostsCount: json['reposts_count'] as int?,
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'username': username,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'reposts_count': repostsCount,
      'image_url': imageUrl,
    };
  }

  bool hasImage() => imageUrl != null && imageUrl!.isNotEmpty;
}
