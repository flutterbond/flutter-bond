import 'package:bond/core/app_localizations.dart';
import 'package:bond_notifications/bond_notifications.dart';
import 'package:flutter/material.dart';
import 'package:bond_core/bond_core.dart';

import 'widgets/notification_item.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    required this.notificationCenterProvider,
    super.key,
  });

  final NotificationCenterProvider notificationCenterProvider;

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.removeListener(() {
      _scrollControllerListener(context);
    });
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations.notification_page_title),
        actions: [
          StreamBuilder<int>(
            stream: widget.notificationCenterProvider.unreadNotificationsCount,
            initialData: widget.notificationCenterProvider
                .currentServerNotificationData?.data.data
                .where((element) => element.readAt == null)
                .length,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasData) {
                final hasUnreadNotifications = snapshot.data! > 0;
                return Visibility(
                  visible: hasUnreadNotifications,
                  child: IconButton(
                    onPressed: widget.notificationCenterProvider.readAll,
                    splashRadius: 20,
                    icon: Icon(
                      hasUnreadNotifications
                          ? Icons.notifications
                          : Icons.notifications_none,
                    ),
                    iconSize: 20,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<ServerNotificationData>(
        stream: widget.notificationCenterProvider.notifications,
        initialData:
            widget.notificationCenterProvider.currentServerNotificationData,
        builder: (BuildContext context,
            AsyncSnapshot<ServerNotificationData> snapshot) {
          if (snapshot.hasData) {
            final notifications = snapshot.data!.data.data;
            if (notifications.isEmpty) {
              return const Icon(Icons.notifications_none);
            } else {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 20),
                itemCount: notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  final notification = notifications[index];
                  return NotificationItem(
                    onTap: () =>
                        widget.notificationCenterProvider.onTap(notification),
                    senderName: notification.senderName ?? '',
                    senderImage: notification.senderImage ?? '',
                    notificationTitle: notification.body,
                    isRead: notification.read,
                    createAt: notification.createdAt,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 1),
              );
            }
          } else {
            return CircularProgressIndicator(
              color: context.colorScheme.primary,
            );
          }
        },
      ),
    );
  }

  void _scrollControllerListener(BuildContext context) {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    double delta = 200.0;
    if (maxScroll - currentScroll <= delta) {
      widget.notificationCenterProvider.load();
    }
  }
}
