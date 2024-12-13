package com.example.incoming_call_locker
import android.app.admin.DeviceAdminReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class MyDeviceAdminReceiver : DeviceAdminReceiver() {

    // Called when the app is enabled as a device administrator
    override fun onEnabled(context: Context, intent: Intent) {
        super.onEnabled(context, intent)
        Log.d("MyDeviceAdminReceiver", "onEnabled")
        // Code here will run when the app gets device admin privileges
        // Example: Log an event, show a toast, etc.
    }

    // Called when the app loses device administrator privileges
    override fun onDisabled(context: Context, intent: Intent) {
        super.onDisabled(context, intent)
        Log.d("MyDeviceAdminReceiver", "onDisabled")
        // Code here will run when the app loses device admin privileges
        // Example: Clean up any resources or notify the user
    }
}