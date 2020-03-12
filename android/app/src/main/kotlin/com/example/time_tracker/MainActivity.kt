package com.example.time_tracker

import android.content.Context
import android.os.PowerManager
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val WAKE_LOCK_CHANNEL_NAME = "time_tracker/wake_lock"

    private lateinit var wakeLock: PowerManager.WakeLock

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WAKE_LOCK_CHANNEL_NAME)
                .setMethodCallHandler(object: MethodChannel.MethodCallHandler {
                    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                        if (call.method.equals("accureWakeLock")) accureWakeLock()
                        if (call.method.equals("releaseWakeLock")) releaseWakeLock()
                    }
                })

    }

    fun accureWakeLock() {
        val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
        wakeLock = pm.newWakeLock(PowerManager.SCREEN_DIM_WAKE_LOCK, "time_tracker:wakelock")
        wakeLock.acquire();
    }

    fun releaseWakeLock() {
        if (wakeLock?.isHeld) {
            wakeLock.release()
        }
    }
}
