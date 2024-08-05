package com.example.incoming_call_locker

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.IBinder
import android.telephony.TelephonyManager
import android.util.Log
import androidx.core.app.NotificationCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class IncomingCallReceiverService : Service() {
    private var methodChannel: MethodChannel? = null
    private val channelId = "CallDetectionServiceChannel"
//    private lateinit var flutterEngine: FlutterEngine
    private val channel = "com.example.incoming_call_locker/incomingCall"
//    private lateinit var incomingCallReceiver: IncomingCallReceiver
    override fun onCreate() {
        super.onCreate()
        Log.d("IncomingCallReceService", "Service created")
        // Create the notification channel
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                    channelId,
                    "Call Detection Service Channel",
                    NotificationManager.IMPORTANCE_DEFAULT
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }

        val notification: Notification = NotificationCompat.Builder(this, channelId)
                .setContentTitle("Call Detection Service")
                .setContentText("Listening for incoming calls")
                .setSmallIcon(R.drawable.notification_icon)
                .build()

        startForeground(1, notification)
//        flutterEngine = FlutterEngine(this).apply {
//            dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
//        }
//
//        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
//        incomingCallReceiver = IncomingCallReceiver().apply {
//            setMethodChannel(methodChannel)
//        }

//        val filter = IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED)
//        registerReceiver(incomingCallReceiver, filter)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("IncomingCallReceService", "Service onStartCommand")
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
    override fun onDestroy() {
        super.onDestroy()
//        unregisterReceiver(incomingCallReceiver)
//        flutterEngine.destroy()
    }
}