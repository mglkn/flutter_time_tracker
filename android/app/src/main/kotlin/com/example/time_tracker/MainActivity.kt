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
            var time = count

            if (sink != null) {
                timer = object : CountDownTimer(count.toLong() * 1000, 250) {
                    override fun onFinish() {
                        timer.cancel()
                    }

                    override fun onTick(millisUntilFinished: Long) {
                        val secondsRemaining = (millisUntilFinished / 1000).toInt()
                        if (secondsRemaining != time) {
                            time = secondsRemaining
                            sink.success(time)
                        }
                    }
                }
                timer.start()
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
