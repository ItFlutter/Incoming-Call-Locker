package com.example.incoming_call_locker


import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.IntentFilter
import android.telephony.TelephonyManager

import android.media.MediaPlayer
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import androidx.annotation.RequiresApi

class MainActivity: FlutterActivity() {
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//    }
//    private val channel="com.example.incoming_call_locker/channel";
    private val channel = "com.example.incoming_call_locker/incomingCall"
    override fun configureFlutterEngine(@NonNull flutterEngine:FlutterEngine){
        Log.d("MainActivity", "configureFlutterEngine")
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        val methodChannel =   MethodChannel(flutterEngine.dartExecutor.binaryMessenger,channel)
        val incomingCallReceiver = IncomingCallReceiver()
        incomingCallReceiver.setMethodChannel(methodChannel)
        val filter = IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED)
        registerReceiver(incomingCallReceiver, filter)

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

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("MainActivity", "onCreate")
        val serviceIntent = Intent(this, IncomingCallReceiverService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Log.d("MainActivity", ">=Oreo")
            startService(serviceIntent)
        } else {
            Log.d("MainActivity", "Not Oreo")
            startService(serviceIntent)
        }

    }
}
