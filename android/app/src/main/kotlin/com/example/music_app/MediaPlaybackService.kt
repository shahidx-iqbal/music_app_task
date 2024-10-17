package com.example.music_app

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import android.util.Log


class PlaybackService : Service() {

    private val CHANNEL_ID = "MusicPlaybackServiceChannel"

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }
override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
    val title = intent?.getStringExtra("title") ?: "Unknown Title"
    val artist = intent?.getStringExtra("artist") ?: "Unknown Artist"
val isPlaying = intent?.getBooleanExtra("isPlaying", false) ?: false

    // Build notification for foreground service
    val notificationIntent = Intent(this, MainActivity::class.java)
    val pendingIntent = PendingIntent.getActivity(
        this,
        0,
        notificationIntent,
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
    )

    val notificationBuilder = NotificationCompat.Builder(this, CHANNEL_ID)
        .setSmallIcon(R.drawable.ic_music_note) // Ensure you have this icon
        .setContentIntent(pendingIntent)
        .setContentTitle("Now Playing: $title")
        .setContentText("Artist: $artist")

    // Adjust notification based on the isPlaying state
    if (isPlaying) {
        notificationBuilder.addAction(
            R.drawable.ic_pause, // Replace with your pause icon
            "Pause",
            // Add a PendingIntent to handle pause action
            PendingIntent.getService(
                this,
                0,
                Intent(this, PlaybackService::class.java).setAction("PAUSE"),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
        )
    } else {
        notificationBuilder.addAction(
            R.drawable.ic_play, // Replace with your play icon
            "Play",
            // Add a PendingIntent to handle play action
            PendingIntent.getService(
                this,
                0,
                Intent(this, PlaybackService::class.java).setAction("PLAY"),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
        )
    }

    val notification: Notification = notificationBuilder.build()

        startForeground(1, notification)

        // Add your music playback logic here

        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        // Handle stopping of music playback here
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

   private fun createNotificationChannel() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        val serviceChannel = NotificationChannel(
            CHANNEL_ID,
            "Music Playback Service Channel",
            NotificationManager.IMPORTANCE_DEFAULT
        )
        val manager = getSystemService(NotificationManager::class.java)
        if (manager != null) {
            manager.createNotificationChannel(serviceChannel)
            Log.d("PlaybackService", "Notification channel created successfully")
        } else {
            Log.e("PlaybackService", "Notification Manager is null")
        }
    } else {
        Log.d("PlaybackService", "Notification channel not needed for API < 26")
    }
}
}
