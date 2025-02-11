import 'package:flutter/material.dart';
import 'package:bond_core/bond_core.dart';

import 'badge_unread_notification.dart';
import 'header_title_image.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    required this.onTap,
    required this.senderName,
    required this.senderImage,
    required this.notificationTitle,
    required this.isRead,
    required this.createAt,
    super.key,
  });

  final VoidCallback onTap;
  final String senderName;
  final String senderImage;
  final String notificationTitle;
  final bool isRead;
  final DateTime createAt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header Title Image
                  HeaderTitleImage(
                    senderName: senderName,
                    senderImage: senderImage,
                  ),
                  const SizedBox(height: 4),

                  /// Title
                  Text(
                    notificationTitle,
                    style: context.textTheme.titleSmall,
                    softWrap: true,
                  ),

                  /// Time Ago
                  Text(
                    createAt.toIso8601String(),
                    style: context.textTheme.bodySmall,
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            BadgeUnreadNotification(isRead: isRead)
          ],
        ),
      ),
    );
  }
}
