package com.example.incoming_call_locker
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.IntentFilter
import android.telephony.TelephonyManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.annotation.RequiresApi
import android.media.MediaPlayer
import android.net.Uri
import android.os.PowerManager
import android.provider.Settings
import android.view.WindowManager
import android.annotation.SuppressLint
@Suppress("DEPRECATION")
class MainActivity: FlutterActivity() {
    //    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//    }
//    private val channel="com.example.incoming_call_locker/channel";
    companion object {
        var isAppRunning: Boolean = false
            private set
    }
    private lateinit var incomingCallReceiver: IncomingCallReceiver
    private val channel = "com.example.incoming_call_locker/incomingCall"
    override fun configureFlutterEngine(@NonNull flutterEngine:FlutterEngine){
        Log.d("MainActivity", "configureFlutterEngine")
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        val methodChannel =   MethodChannel(flutterEngine.dartExecutor.binaryMessenger,channel)
        incomingCallReceiver = IncomingCallReceiver().apply {
            setMethodChannel(methodChannel)
        }
        val filter = IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED)
        registerReceiver(incomingCallReceiver, filter)
    }
    //                .setMethodCallHandler { call, result ->
//            if(call.method=="playMusic"){
//                val player=MediaPlayer.create(this,Settings.System.DEFAULT_RINGTONE_URI) as MediaPlayer;
////This Not Work   player.setLooping(true);
////                player.start();
//                result.success("I am java");
//            }else{
//                result.notImplemented();
//            }
//        }
//fun requestIgnoreBatteryOptimizations(context: Context) {
//    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//        val packageName = context.packageName
//        val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
//        intent.data = Uri.parse("package:$packageName")
//        context.startActivity(intent)
//    }
//}
//    @RequiresApi(Build.VERSION_CODES.M)
//    @SuppressLint("ServiceCast")
//    fun isIgnoringBatteryOptimizations(context: Context): Boolean {
//        val powerManager = context.getSystemService(Context.POWER_SERVICE) as PowerManager
//        val packageName = context.packageName
//        return powerManager.isIgnoringBatteryOptimizations(packageName)
//    }
    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//    if (!isIgnoringBatteryOptimizations(this)) {
//        requestIgnoreBatteryOptimizations(this)
//    }
        isAppRunning = true
        Log.d("MainActivity", "onCreate")
        val callerNumber = intent.getStringExtra("caller_number") ?: ""
        val callerName = intent.getStringExtra("caller_name") ?: ""
        Log.d("caller_number", callerNumber)
        Log.d("caller_name", callerName)
        if (callerNumber.isNotEmpty()) {
            // Store the data in SharedPreferences
            val sharedPreferences = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
            val editor = sharedPreferences.edit().apply {
                putString("flutter.caller_number", callerNumber)
                putString("flutter.caller_name", callerName)
                apply()
            }
                            moveTaskToBack(true)
//            val startActivity= sharedPreferences.getString("flutter.startactivity", "");
//            if(startActivity=="start"){
//                Log.d("MainActivity", "startActivity==start")
//                val editor = sharedPreferences.edit()
//                // Remove the key "flutter.startactivity"
//                 editor.remove("flutter.startactivity")
//                 // Apply the changes
//                 editor.apply()
//                Log.d("MainActivity", "Remove startactivity ${sharedPreferences.getString("flutter.startactivity", "")}")
//                moveTaskToBack(true)
//            }
//            // Add flags to show the activity over the lock screen
//            window.addFlags(WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED)
//            window.addFlags(WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD)
//            window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
//            window.addFlags(WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON)
//            window.addFlags(WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON)
        }
        val serviceIntent = Intent(this, IncomingCallReceiverService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Log.d("MainActivity", ">=Oreo")
            startForegroundService(serviceIntent)
        } else {
            Log.d("MainActivity", "Not Oreo")
            startService(serviceIntent)
        }
    }
    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(incomingCallReceiver)
        isAppRunning = false
//        flutterEngine.destroy()
    }
    fun isFlutterAppRunning(): Boolean = isAppRunning
}
