import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:social_app/features/feed/presentation/bloc/feed/feed_event.dart';
import 'package:social_app/features/feed/presentation/bloc/feed/feed_state.dart';
import 'package:social_app/features/feed/presentation/bloc/post/create_post_bloc.dart';
import 'package:social_app/features/feed/presentation/bloc/post/create_post_event.dart';
import 'package:social_app/features/feed/presentation/bloc/post/create_posts_state.dart';
import 'package:social_app/features/feed/presentation/widget/post_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    context.read<FeedBloc>().add(FetchPostsRequested());
    super.initState();
  }

  // void _showCreatePostDialog(BuildContext context) {
  //   final TextEditingController contentController = TextEditingController();
  //   final formKey = GlobalKey<FormState>();

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return BlocConsumer<CreatePostBloc, CreatePostsState>(
  //         listener: (context, state) {
  //           if (state is CreatePostSuccess) {
  //             Navigator.pop(context);
  //             context.read<FeedBloc>().add(FetchPostsRequested());
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('Post created successfully')),
  //             );
  //           } else if (state is CreatePostFailure) {
  //             Navigator.pop(context);
  //             ScaffoldMessenger.of(
  //               context,
  //             ).showSnackBar(SnackBar(content: Text(state.messsage)));
  //           }
  //         },
  //         builder: (context, state) {
  //           return AlertDialog(
  //             title: const Text('Create Post'),
  //             content: Form(
  //               key: formKey,
  //               child: TextFormField(
  //                 controller: contentController,
  //                 decoration: const InputDecoration(
  //                   hintText: "What's on your mind ?",
  //                 ),
  //                 maxLines: 5,
  //                 validator: (value) => value == null || value.trim().isEmpty
  //                     ? 'Content is required'
  //                     : null,
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 child: const Text('Cancel'),
  //               ),
  //               ElevatedButton(
  //                 onPressed: state is CreatePostLoading
  //                     ? null
  //                     : () {
  //                         if (formKey.currentState!.validate()) {
  //                           context.read<CreatePostBloc>().add(
  //                             CreatePostRequested(
  //                               username: '1234',
  //                               content: 'fabrico',
  //                               userId: contentController.text.trim(),
  //                               imageUrl: '',
  //                             ),
  //                           );
  //                         }
  //                       },
  //                 child: state is CreatePostLoading
  //                     ? const SizedBox(
  //                         height: 16,
  //                         width: 16,
  //                         child: CircularProgressIndicator(strokeWidth: 2),
  //                       )
  //                     : const Text('Post'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _showCreatePostModal(BuildContext context) {
    final TextEditingController contentController = TextEditingController();
    final formkey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return BlocConsumer<CreatePostBloc, CreatePostsState>(
          listener: (context, state) {
            if (state is CreatePostSuccess) {
              Navigator.pop(context);
              context.read<FeedBloc>().add(FetchPostsRequested());
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Post created!')));
            } else if (state is CreatePostFailure) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.messsage)));
            }
          },
          builder: (context, state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: contentController,
                              maxLines: null,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "What's on your mind ?",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              validator: (value) =>
                                  value == null || value.trim().isEmpty
                                  ? 'Content is required'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: state is CreatePostLoading
                              ? null
                              : () {
                                  if (formkey.currentState!.validate()) {
                                    context.read<CreatePostBloc>().add(
                                      CreatePostRequested(
                                        username: '1234',
                                        content: 'fabrico',
                                        userId: contentController.text.trim(),
                                        imageUrl: '',
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: state is CreatePostLoading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Post',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.5,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundColor: Colors.grey[800]),
        ),
        centerTitle: true,
        title: Image.asset('assets/images/logo.jpg', height: 32, width: 32),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mail_outline, color: Colors.white),
          ),
        ],
      ),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            final posts = state.posts;
            if (posts.isEmpty) {
              return const Center(child: Text('No posts available'));
            }
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) => PostCard(post: posts[index]),
            );
          } else if (state is FeedFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostModal(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
