import 'package:bond/core/resources/app_keys.dart';
import 'package:bond/features/post/data/models/post.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/post_provider.dart';
import 'views/share_button.dart';

class PostDetailsPage extends ConsumerWidget {
  const PostDetailsPage({
    super.key,
    required this.id,
    this.post,
  });

  final String id;
  final Post? post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (post != null) {
      return _PostDetailsView(post: post!);
    } else {
      final postProvider = ref.watch(postFeatureProvider(id));
      return postProvider.when(
        data: (post) => _PostDetailsView(
          post: post,
        ),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const CircularProgressIndicator.adaptive(),
      );
    }
  }
}

class _PostDetailsView extends StatelessWidget {
  final Post post;

  const _PostDetailsView({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppKeys.postDetailsPage,
      appBar: AppBar(
        title: Text(post.author.name),
        actions: [
          ShareButton(
            key: AppKeys.shareButton,
            postImageUrl: post.urls.full, // Pass the post image URL
          )
        ],
      ),
      body: SizedBox(
        height: double.maxFinite,
        child: Hero(
          tag: post.uuid,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              post.urls.regular,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
