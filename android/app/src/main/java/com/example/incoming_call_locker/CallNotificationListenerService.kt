package com.example.incoming_call_locker

import android.app.Notification
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log

class CallNotificationListenerService : NotificationListenerService() {

    companion object {
        var isCallPopup: Boolean = false
        var isFullScreenCall: Boolean = false
    }

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        if (sbn.notification.category == Notification.CATEGORY_CALL) {
            if (sbn.notification.fullScreenIntent != null) {
                Log.d("CallNotification", "Full-screen call notification received")
                isFullScreenCall = true
                isCallPopup = false
            } else {
                Log.d("CallNotification", "Heads-up call notification received")
                isCallPopup = true
                isFullScreenCall = false
            }
        }
    }

    override fun onNotificationRemoved(sbn: StatusBarNotification) {
        if (sbn.notification.category == Notification.CATEGORY_CALL) {
            Log.d("CallNotification", "Call notification removed")
            isCallPopup = false
            isFullScreenCall = false
        }
    }
}