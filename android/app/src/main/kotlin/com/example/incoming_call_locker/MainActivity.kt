package com.example.incoming_call_locker


import androidx.annotation.NonNull
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.IntentFilter
import android.telephony.TelephonyManager

import android.media.MediaPlayer
import android.provider.Settings
class MainActivity: FlutterActivity() {
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//    }
//    private val channel="com.example.incoming_call_locker/channel";
    private val channel = "com.example.incoming_call_locker/incomingCall"
    override fun configureFlutterEngine(@NonNull flutterEngine:FlutterEngine){
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        val methodChannel =   MethodChannel(flutterEngine.dartExecutor.binaryMessenger,channel)

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
        val incomingCallReceiver = IncomingCallReceiver()
        incomingCallReceiver.setMethodChannel(methodChannel)

        val filter = IntentFilter(TelephonyManager.ACTION_PHONE_STATE_CHANGED)
        registerReceiver(incomingCallReceiver, filter)
    }
}
