package com.example.incoming_call_locker

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log

class BootReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            handleBootCompleted(context)
        }
    }

    private fun handleBootCompleted(context: Context) {
        Log.d("BootReceiver", "Device booted, starting IncomingCallReceiverService")
        val serviceIntent = Intent(context, IncomingCallReceiverService::class.java)
        startServiceBasedOnVersion(context, serviceIntent)
    }

    private fun startServiceBasedOnVersion(context: Context, serviceIntent: Intent) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(serviceIntent)
        } else {
            context.startService(serviceIntent)
        }
    }
}