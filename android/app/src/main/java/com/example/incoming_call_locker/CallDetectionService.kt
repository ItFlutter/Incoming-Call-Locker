package com.example.incoming_call_locker

import android.app.Service
import android.content.Intent
import android.content.IntentFilter
import android.os.IBinder
import android.telephony.TelephonyManager
import io.flutter.plugin.common.MethodChannel

class CallDetectionService : Service() {
    private var methodChannel: MethodChannel? = null

    override fun onCreate() {
        super.onCreate()

        // Retrieve the MethodChannel from the Singleton
        methodChannel = MethodChannelHolder.methodChannel

        // Initialize and register the broadcast receiver
        val incomingCallReceiver = IncomingCallReceiver()
        incomingCallReceiver.setMethodChannel(methodChannel!!)

        val filter = IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED)
        registerReceiver(incomingCallReceiver, filter)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }
}