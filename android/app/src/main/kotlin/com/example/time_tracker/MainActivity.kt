package com.example.time_tracker

import android.os.CountDownTimer
import androidx.annotation.NonNull;
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val EVENT_CHANNEL_NAME = "time_tracker/ticker"
    private lateinit var timer : CountDownTimer

    private val handler = object : EventChannel.StreamHandler {
        override fun onListen(arguments: Any?, sink: EventChannel.EventSink?) {
            val count = arguments as Int

            if (sink != null) {
                timer = object : CountDownTimer(count.toLong() * 1000, 1000) {
                    override fun onFinish() {
                        sink.success(0)
                        timer.cancel()
                    }

                    override fun onTick(millisUntilFinished: Long) {
                        val secondsRemaining = millisUntilFinished / 1000
                        sink.success(secondsRemaining)
                    }
                }
                timer.start()
            } else {
                // todo throw error
            }
        }

        override fun onCancel(arguments: Any?) {
            timer.cancel()
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        val eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL_NAME)
        eventChannel.setStreamHandler(handler)
    }
}
