import 'package:social_app/features/feed/domain/entities/post_entity.dart';
import 'package:social_app/features/feed/domain/repository/post_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePostRepository implements PostRepository {
  final SupabaseClient client;
  SupabasePostRepository({required this.client});
  String tableName = 'posts';

  @override
  Future<bool> createPost({required PostEntity post}) async {
    try {
      final data = post.toJson();
      await client.from('posts').insert(data);
      return true;
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  @override
  Future<List<PostEntity>> fetchPosts() async {
    try {
      final response = await client
          .from(tableName)
          .select()
          .order('created_at', ascending: false);
      return (response as List).map((json) {
        return PostEntity.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }
}
