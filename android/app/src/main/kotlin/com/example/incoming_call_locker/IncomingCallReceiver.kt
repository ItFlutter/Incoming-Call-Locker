package com.example.incoming_call_locker
import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.ContentResolver
import android.content.Context
import android.content.Context.TELEPHONY_SERVICE
import android.content.Intent
import android.provider.ContactsContract
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.plugin.common.MethodChannel


@Suppress("DEPRECATION")
class IncomingCallReceiver: BroadcastReceiver() {
    private var methodChannel: MethodChannel? = null
    fun setMethodChannel(channel: MethodChannel) {
        Log.d("IncomingCallReceiver", "setMethodChannel")
        methodChannel = channel
    }
//        companion object {
//    }
    override fun onReceive(context: Context, intent: Intent) {
    Log.d("IncomingCallReceiver", "onReceive called")
        if (intent.action == TelephonyManager.ACTION_PHONE_STATE_CHANGED) {
            val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
//            val incomingNumber = intent.extras?.getString("incoming_number")

            val incomingNumber = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER )
//            if (state == TelephonyManager.EXTRA_STATE_RINGING ) {
//                // Notify Flutter app about the incoming call
//                methodChannel?.invokeMethod("incomingCall", incomingNumber)
//            }
            Log.d("IncomingCallReceiver", "State: $state, Incoming number: $incomingNumber")
            if (incomingNumber != null) {
                val callerName = getContactName(context, incomingNumber)
            when (state) {
                TelephonyManager.EXTRA_STATE_RINGING -> {
                    // Launch the Flutter activity
                    val flutterIntent = Intent(context, MainActivity::class.java)
                    flutterIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                    context.startActivity(flutterIntent)
                    // Notify Flutter app about the incoming call
                    Log.d("IncomingCallReceiver", "Incoming call from $incomingNumber")
                    methodChannel?.invokeMethod("incomingCall", mapOf("number" to incomingNumber, "name" to callerName))

                }
//                TelephonyManager.EXTRA_STATE_OFFHOOK -> {
//                    // Notify Flutter app that the call was answered
//                    methodChannel?.invokeMethod("callAnswered", incomingNumber)
//                }
                TelephonyManager.EXTRA_STATE_IDLE -> {
                    // Notify Flutter app that the call ended
                    Log.d("IncomingCallReceiver", "Call ended from $incomingNumber")
                    methodChannel?.invokeMethod("callEnded", mapOf("number" to incomingNumber, "name" to callerName))
                }
            }}
        }
    }
    @SuppressLint("Range")
    private fun getContactName(context: Context, phoneNumber: String): String? {
        val contentResolver: ContentResolver = context.contentResolver
        val uri = ContactsContract.PhoneLookup.CONTENT_FILTER_URI.buildUpon().appendPath(phoneNumber).build()
        val cursor = contentResolver.query(uri, arrayOf(ContactsContract.PhoneLookup.DISPLAY_NAME), null, null, null)
        var contactName: String? = ""
        cursor?.use {
            if (it.moveToFirst()) {
                contactName = it.getString(it.getColumnIndex(ContactsContract.PhoneLookup.DISPLAY_NAME))
            }
        }
        return contactName
    }
}

