import 'package:flutter/material.dart';
import 'package:social_app/core/utils.dart';
import 'package:social_app/features/feed/domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 20, backgroundColor: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.username,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Spacer(),
                        Text(
                          formatDate(post.createdAt),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      post.content * 20,
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (post.imageUrl != null && post.imageUrl!.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(image: NetworkImage(post.imageUrl!)),
            ),
          ],
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PostStat(icon: Icons.favorite_border, count: post.likesCount),
              _PostStat(icon: Icons.favorite_border, count: post.commentsCount),
              _PostStat(icon: Icons.favorite_border, count: post.repostsCount),
              const Icon(Icons.share, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostStat extends StatelessWidget {
  final IconData icon;
  final int? count;
  const _PostStat({super.key, required this.icon, this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 10, color: Colors.grey),
        const SizedBox(width: 10),
        Text(
          '${count ?? 0}',
          style: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ],
    );
  }
}
