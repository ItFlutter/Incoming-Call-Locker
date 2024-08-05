//package com.example.incoming_call_locker
//
//import android.app.Notification
//import android.app.NotificationChannel
//import android.app.NotificationManager
//import android.app.PendingIntent
//import android.app.Service
//import android.content.Context
//import android.content.Intent
//import android.content.IntentFilter
//import android.os.Build
//import android.os.IBinder
//import android.telephony.TelephonyManager
//import androidx.core.app.NotificationCompat
//
//class IncomingCallService : Service() {
//
//    private lateinit var incomingCallReceiver: IncomingCallReceiver
//
//    override fun onCreate() {
//        super.onCreate()
//        incomingCallReceiver = IncomingCallReceiver()
//        val filter = IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED)
//        registerReceiver(incomingCallReceiver, filter)
//    }
//
//    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
//        createNotificationChannel()
//        val notificationIntent = Intent(this, MainActivity::class.java)
//        val pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE)
//        val notification: Notification = NotificationCompat.Builder(this, CHANNEL_ID)
//                .setContentTitle("Incoming Call Service")
//                .setContentText("Listening for incoming calls")
//                .setSmallIcon(R.drawable.notification_icon)
//                .setContentIntent(pendingIntent)
//                .build()
//
//        startForeground(1, notification)
//
//        return START_STICKY
//    }
//
//    override fun onDestroy() {
//        super.onDestroy()
//        unregisterReceiver(incomingCallReceiver)
//    }
//
//    override fun onBind(intent: Intent?): IBinder? {
//        return null
//    }
//
//    private fun createNotificationChannel() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            val serviceChannel = NotificationChannel(
//                    CHANNEL_ID,
//                    "Incoming Call Service Channel",
//                    NotificationManager.IMPORTANCE_DEFAULT
//            )
//            val manager = getSystemService(NotificationManager::class.java)
//            manager?.createNotificationChannel(serviceChannel)
//        }
//    }
//
//    companion object {
//        private const val CHANNEL_ID = "IncomingCallServiceChannel"
//    }
//}
