import 'package:bond/core/resources/app_keys.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: AppKeys.morePage,
      appBar: AppBar(
        title: const Text("More"),
      ),
      body: const SizedBox(),
    );
  }
}
