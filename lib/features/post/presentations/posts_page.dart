import 'package:bond/features/post/presentations/providers/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'views/home_app_bar.dart';
import 'views/post_item.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(postsProvider);
    final postsController = ref.read(postsProvider.notifier);
    return Scaffold(
      appBar: const HomeAppBar(),
      body: postsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (posts) =>
            SingleChildScrollView(
              controller: postsController.scrollController,
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    children: posts.data.data.map((post) {
                      return PostItem(post: post);
                    }).toList(),
                  ),
                  if (posts.isLoading) const CircularProgressIndicator
                      .adaptive(),
                ],
              ),
            ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}