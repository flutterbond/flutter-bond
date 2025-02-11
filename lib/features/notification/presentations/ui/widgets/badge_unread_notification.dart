import 'package:flutter/material.dart';
import 'package:bond_core/bond_core.dart';

class BadgeUnreadNotification extends StatelessWidget {
  const BadgeUnreadNotification({
    this.isRead = false,
    super.key,
  });

  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return !isRead
        ? Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          )
        : const SizedBox.shrink();
  }
}
