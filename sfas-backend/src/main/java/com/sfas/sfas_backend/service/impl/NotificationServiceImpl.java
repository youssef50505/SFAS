package com.sfas.sfas_backend.service.impl;

import com.sfas.sfas_backend.event.NotificationEvent;
import com.sfas.sfas_backend.service.NotificationService;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@Service
public class NotificationServiceImpl implements NotificationService {

    private final List<String> notifications = new CopyOnWriteArrayList<>();

    @Async
    @EventListener
    public void handleNotificationEvent(NotificationEvent event) {
        String logMessage = "Notification to " + event.userEmail() + ": " + event.message();
        System.out.println(logMessage);
        notifications.add(0, logMessage); // Add to the beginning
        
        if (notifications.size() > 50) {
            notifications.remove(notifications.size() - 1);
        }
    }

    @Override
    public List<String> getRecentNotifications() {
        return List.copyOf(notifications);
    }
}
