import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/notifications_bloc.dart';
import '../bloc/notifications_state.dart';

class NotificationsSheet extends StatelessWidget {
  const NotificationsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Notifications', style: theme.textTheme.headlineMedium),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Mark all as read')),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 400,
            child: BlocBuilder<NotificationsBloc, NotificationsState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: CircularProgressIndicator()),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (message) => Center(child: Text(message, style: const TextStyle(color: Colors.red))),
                  loaded: (notifications) {
                    if (notifications.isEmpty) {
                      return const Center(child: Text('No new notifications'));
                    }
                    return ListView.separated(
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                            child: Icon(Remix.notification_3_line, color: theme.colorScheme.primary),
                          ),
                          title: Text('System Update', style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                          subtitle: Text(notification),
                          trailing: Text('Just now', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                        ).animate().fadeIn(delay: (100 * index).ms);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => const NotificationsSheet(),
    );
  }
}
