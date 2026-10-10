import 'package:material_ui/material_ui.dart';

class ModalBottomSheetPage<T> extends Page<T> {
  final Widget child;
  final bool isScrollControlled;

  const ModalBottomSheetPage({
    required this.child,
    this.isScrollControlled = false,
    super.key,
    super.name,
    super.arguments,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute<T>(
      builder: (BuildContext context) {
        return child;
      },
      isScrollControlled: true,
    );
  }
}