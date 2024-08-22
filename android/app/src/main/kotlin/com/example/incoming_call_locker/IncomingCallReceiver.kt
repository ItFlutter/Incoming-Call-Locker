package com.example.incoming_call_locker
import android.annotation.SuppressLint
import android.app.Activity
import android.content.BroadcastReceiver
import android.content.ContentResolver
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.provider.ContactsContract
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import androidx.core.app.ActivityCompat.finishAffinity
import android.content.Context.POWER_SERVICE
import android.content.Context.TELEPHONY_SERVICE
import android.os.PowerManager
import androidx.core.app.ActivityCompat.finishAfterTransition
import kotlin.system.exitProcess

@Suppress("DEPRECATION")
class IncomingCallReceiver: BroadcastReceiver() {
    private var methodChannel: MethodChannel? = null
    fun setMethodChannel(channel: MethodChannel) {
        Log.d("IncomingCallReceiver", "setMethodChannel")
        methodChannel = channel
    }
    override fun onReceive(context: Context, intent: Intent) {
        val sharedPreferences: SharedPreferences = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
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
//                        // Acquire a wake lock to wake up the device and keep it awake long enough
//                        val powerManager = context.getSystemService(POWER_SERVICE) as PowerManager
//                        val wakeLock = powerManager.newWakeLock(
//                                PowerManager.FULL_WAKE_LOCK or PowerManager.ACQUIRE_CAUSES_WAKEUP or PowerManager.ON_AFTER_RELEASE,
//                                "app:incomingCallLock"
//                        )
//                        wakeLock.acquire(10 * 60 * 1000L /*10 minutes*/)
//                     Launch the Flutter activity
                        if (MainActivity().isFlutterAppRunning()) {
                            Log.d("IncomingCallReceiver", "The Flutter app is currently running")
                            methodChannel?.invokeMethod("incomingCall", mapOf("number" to incomingNumber, "name" to callerName))
                        } else {
                            Log.d("IncomingCallReceiver", "The Flutter app is not running")

                            val lockactivited= sharedPreferences.getBoolean("flutter.lockactivited", false)
                            val callingsetting= sharedPreferences.getLong("flutter.callingsetting", 0).toInt()
                            if(lockactivited==true){
                                if(callingsetting==1 && callerName==""){
                                    Log.d("IncomingCallReceiver", "Unknown Contacts")
                                    val editor = sharedPreferences.edit()
                                    editor.putString("flutter.startactivity", "start")
                                    editor.apply()
                                    val flutterIntent = Intent(context, MainActivity::class.java)
                                    flutterIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                                    flutterIntent.putExtra("caller_number", incomingNumber)
//                                    flutterIntent.putExtra("caller_name", callerName)
                                    context.startActivity(flutterIntent)
                                }
                                if(callingsetting==0) {
                                    Log.d("IncomingCallReceiver", "All Contacts")
                                    val editor = sharedPreferences.edit()
                                    Log.d("IncomingCallReceiver", "edit shared prefrences")
                                    editor.putString("flutter.startactivity", "start")
                                    Log.d("IncomingCallReceiver", "put in shared prefrences start")
                                    editor.apply()
                                    Log.d("IncomingCallReceiver", "apply editor")
                                    val flutterIntent = Intent(context, MainActivity::class.java)
                                    Log.d("IncomingCallReceiver", "Intent")
                                    flutterIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                                    Log.d("IncomingCallReceiver", "put flags")
                                    flutterIntent.putExtra("caller_number", incomingNumber)
                                    Log.d("IncomingCallReceiver", "put caller_number")
                                    flutterIntent.putExtra("caller_name", callerName)
                                    Log.d("IncomingCallReceiver", "put caller_name")
                                    context.startActivity(flutterIntent)
                                    Log.d("IncomingCallReceiver", "start activity")
                                }
                                if(callingsetting==2&& callerName!="") {
                                    Log.d("IncomingCallReceiver", "Specific Contacts")
                                    val editor = sharedPreferences.edit()
                                    editor.putString("flutter.startactivity", "start")
                                    editor.apply()
                                    val flutterIntent = Intent(context, MainActivity::class.java)
                                    flutterIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                                    flutterIntent.putExtra("caller_number", incomingNumber)
                                    flutterIntent.putExtra("caller_name", callerName)
                                    context.startActivity(flutterIntent)
                                }
                            }

                        }
//                        // Release the wake lock after starting the activity
//                        wakeLock.release()
//                     Launch the Flutter overlay
//                    val overlayIntent = Intent(context, OverlayService::class.java)
//                    overlayIntent.putExtra("caller_number", incomingNumber)
//                    overlayIntent.putExtra("caller_name", callerName)
//                    context.startService(overlayIntent)
                        // Notify Flutter app about the incoming call
                        Log.d("IncomingCallReceiver", "Incoming call from $incomingNumber")
                    }
//                TelephonyManager.EXTRA_STATE_OFFHOOK -> {
//                    // Notify Flutter app that the call was answered
//                    methodChannel?.invokeMethod("callAnswered", incomingNumber)
//                }
                    TelephonyManager.EXTRA_STATE_IDLE -> {
                        // Notify Flutter app that the call ended
                        Log.d("IncomingCallReceiver", "Call ended from $incomingNumber")
                        methodChannel?.invokeMethod("callEnded", mapOf("number" to incomingNumber, "name" to callerName))
                        val startActivity= sharedPreferences.getString("flutter.startactivity", "");
                        if(startActivity=="start"){
                            Log.d("IncomingCallReceiver", "startActivity==start")
                            val editor = sharedPreferences.edit()
                            // Remove the key "flutter.startactivity"
                            editor.remove("flutter.startactivity")
                            // Apply the changes
                            editor.apply()
                            Log.d("IncomingCallReceiver", "Remove startactivity ${sharedPreferences.getString("flutter.startactivity", "")}")
                            // Stop the OverlayService when the call ends
//                            val overlayIntent = Intent(context, OverlayService::class.java)
//                            context.stopService(overlayIntent)
                            // Close the app after the call ends
//                            if (context is Activity) {
////                                finishAffinity(context)
//                                exitProcess(0)
//                                Log.d("IncomingCallReceiver", "App is closing.")
//                            }
//                        exitProcess(0)
                        }else{
                            methodChannel?.invokeMethod("callEnded", mapOf("number" to incomingNumber, "name" to callerName))

                        }

    //                        val sharedPreferences: SharedPreferences = context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
    //                        val startActivity= sharedPreferences.getString("flutter.startactivity", "");
    //                        if(startActivity=="start"){
    //                            val editor = sharedPreferences.edit()
    //                            // Remove the key "flutter.startactivity"
    //                            editor.remove("flutter.startactivity")
    //                            // Apply the changes
    //                            editor.apply()
    ////                            finishAffinity(MainActivity());
    //                        }
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

