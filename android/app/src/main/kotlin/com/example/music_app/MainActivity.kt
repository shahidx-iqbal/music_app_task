package com.example.music_app

import android.content.Intent
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.music_app/playback"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startService" -> {
                    // Extract the arguments from Flutter
                    val title = call.argument<String>("title") ?: "Unknown Title"
                    val artist = call.argument<String>("artist") ?: "Unknown Artist"
                    val isPlaying = call.argument<Boolean>("isPlaying") ?: false

                    // Pass the data to the service via an Intent
                    val serviceIntent = Intent(this, PlaybackService::class.java).apply {
                        putExtra("title", title)
                        putExtra("artist", artist)
                        putExtra("isPlaying", isPlaying)
                    }
                    ContextCompat.startForegroundService(this, serviceIntent)
                    result.success("Service started with title: $title, artist: $artist, isPlaying: $isPlaying")
                }
                "stopService" -> {
                    val stopIntent = Intent(this, PlaybackService::class.java)
                    stopService(stopIntent)
                    result.success("Service stopped")
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
