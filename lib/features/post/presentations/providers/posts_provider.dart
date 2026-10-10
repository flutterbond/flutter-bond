import 'dart:developer';

import 'package:bond/features/post/data/api.dart';
import 'package:bond/features/post/data/models/post.dart';
import 'package:bond_core/bond_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'list_state.dart';

// Riverpod 3 retries a failed build() automatically (default policy kept).
final postsProvider =
    AsyncNotifierProvider.autoDispose<PostController, ListState<Post>>(
  () => PostController(sl()),
);

class PostController extends AsyncNotifier<ListState<Post>> {
  PostController(this._api);

  final PostsApi _api;

  // Recreated on every build(): the notifier instance survives rebuilds and
  // retries, while the previous controller is disposed with the old state.
  late ScrollController scrollController;

  @override
  Future<ListState<Post>> build() async {
    _initialize();
    final response = await _api.posts();
    return ListState.data(response);
  }

  void _initialize() {
    final controller = ScrollController()
      ..addListener(_scrollControllerListener);
    scrollController = controller;
    ref.onDispose(
      () {
        controller.removeListener(_scrollControllerListener);
        controller.dispose();
      },
    );
  }

  void _loadMore() async {
    final current = state.requireValue;
    if (!current.hasMoreData) {
      log('_loadMore no more data', name: 'PostController');
      return;
    }
    final nextUrl = current.data.links?.next;
    state = AsyncData(current.loading());
    final result = await AsyncValue.guard(() async {
      final response = await _api.posts(nextUrl);
      return current.success(response);
    });
    if (!ref.mounted) return;
    state = result;
  }

  void _scrollControllerListener() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    const delta = 200.0;
    if (maxScroll - currentScroll <= delta &&
        state.value?.status != ListStatus.loading) {
      _loadMore();
    }
  }
}
