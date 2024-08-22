package com.example.incoming_call_locker
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import io.flutter.plugin.common.MethodChannel
class IncomingCallReceiverService : Service() {
    private var methodChannel: MethodChannel? = null
    private val channelId = "CallDetectionServiceChannel"
    private val channel = "com.example.incoming_call_locker/incomingCall"
    //    private lateinit var flutterEngine: FlutterEngine
//    private lateinit var incomingCallReceiver: IncomingCallReceiver
    override fun onCreate() {
        super.onCreate()
        Log.d("IncomingCallReceService", "Service created")
        createNotificationChannel()
        startForegroundWithNotification() }

//        flutterEngine = FlutterEngine(this).apply {
//            dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
//        }
//        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
//        incomingCallReceiver = IncomingCallReceiver().apply {
//            setMethodChannel(methodChannel)
//        }
//        val filter = IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED)
//        registerReceiver(incomingCallReceiver, filter)

    // Create the notification channel
    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                    channelId,
                    "Call Detection Service Channel",
                    NotificationManager.IMPORTANCE_LOW
            ).apply {
                setSound(null, null) // Disable sound for notifications in this channel Remove the sound from the notification channel
            }
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager?.createNotificationChannel(channel)
//            val manager = getSystemService(NotificationManager::class.java)
//            manager.createNotificationChannel(channel)
        }
    }
    private fun startForegroundWithNotification() {
        val notifyIcon: Int = getDrawableResourceId("mipmap", "icon")
        val notification: Notification = NotificationCompat.Builder(this, channelId)
                .setContentTitle("Call Detection Service")
                .setContentText("Listening for incoming calls")
                .setSmallIcon(notifyIcon)
                .setPriority(NotificationCompat.PRIORITY_LOW) // Set priority to low
                .setDefaults(0) // Remove all default settings (sound, vibration, etc.)
                .setSound(null)
                .build()
        startForeground(1, notification)
    }
    private fun getDrawableResourceId(resType: String, name: String): Int {
        return applicationContext.resources.getIdentifier(String.format("launcher_%s", name), resType, applicationContext.packageName)
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("IncomingCallReceService", "Service onStartCommand")
        return START_STICKY
    }
    override fun onBind(intent: Intent?): IBinder? {
        Log.d("IncomingCallReceService", "onBind Service")
        return null
    }
    override fun onDestroy() {
        super.onDestroy()
        Log.d("IncomingCallReceService", "onDestroy Service")
//        unregisterReceiver(incomingCallReceiver)
//        flutterEngine.destroy()
    }
}