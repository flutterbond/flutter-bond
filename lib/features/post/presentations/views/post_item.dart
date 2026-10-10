import 'package:bond/features/post/data/models/post.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () => context.push('/post/${post.uuid}', extra: post),
        child: Hero(
          tag: post.uuid,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              post.urls.regular,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
