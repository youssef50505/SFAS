import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/notification_repository.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationRepository _notificationRepository;

  NotificationsBloc({required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository,
        super(const NotificationsState.initial()) {
    on<NotificationsEvent>((event, emit) async {
      await event.map(
        loadNotifications: (_) => _onLoadNotifications(emit),
      );
    });
  }

  Future<void> _onLoadNotifications(Emitter<NotificationsState> emit) async {
    emit(const NotificationsState.loading());
    try {
      final notifications = await _notificationRepository.getNotifications();
      emit(NotificationsState.loaded(notifications));
    } catch (e) {
      emit(NotificationsState.error(e.toString()));
    }
  }
}
