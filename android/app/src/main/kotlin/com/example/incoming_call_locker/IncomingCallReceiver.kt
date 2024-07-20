package com.example.incoming_call_locker
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Context.TELEPHONY_SERVICE
import android.content.Intent
import android.telephony.TelephonyManager
import io.flutter.plugin.common.MethodChannel


@Suppress("DEPRECATION")
class IncomingCallReceiver: BroadcastReceiver() {
    private var methodChannel: MethodChannel? = null
    fun setMethodChannel(channel: MethodChannel) {
        methodChannel = channel
    }
//        companion object {
//    }
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == TelephonyManager.ACTION_PHONE_STATE_CHANGED) {
            val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
//            val incomingNumber = intent.extras?.getString("incoming_number")

            val incomingNumber = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER )
//            if (state == TelephonyManager.EXTRA_STATE_RINGING ) {
//                // Notify Flutter app about the incoming call
//                methodChannel?.invokeMethod("incomingCall", incomingNumber)
//            }
            when (state) {
                TelephonyManager.EXTRA_STATE_RINGING -> {
                    // Notify Flutter app about the incoming call
                    methodChannel?.invokeMethod("incomingCall", incomingNumber)
                }
//                TelephonyManager.EXTRA_STATE_OFFHOOK -> {
//                    // Notify Flutter app that the call was answered
//                    methodChannel?.invokeMethod("callAnswered", incomingNumber)
//                }
                TelephonyManager.EXTRA_STATE_IDLE -> {
                    // Notify Flutter app that the call ended
                    methodChannel?.invokeMethod("callEnded", incomingNumber)
                }
            }
        }
    }
}