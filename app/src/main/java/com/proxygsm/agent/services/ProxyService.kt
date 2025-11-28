package com.proxygsm.agent.services

import android.app.*
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import com.proxygsm.agent.MainActivity
import com.proxygsm.agent.R

class ProxyService : Service() {
    
    companion object {
        private const val NOTIFICATION_ID = 9090
        private const val CHANNEL_ID = "proxygsm_service"
    }

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startForeground(NOTIFICATION_ID, createNotification())
        
        // TODO: Initialize WebRTC connection
        // TODO: Start listening for commands
        
        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun createNotification(): Notification {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this, 0, notificationIntent,
            PendingIntent.FLAG_IMMUTABLE
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("ProxyGSM Agent")
            .setContentText("Service is running")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentIntent(pendingIntent)
            .setPriority(NotificationCompat.PRIORITY_MIN) // Stealth mode
            .setOngoing(true)
            .build()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "ProxyGSM Service",
                NotificationManager.IMPORTANCE_MIN // Minimal visibility
            ).apply {
                description = "Background service for ProxyGSM"
                setShowBadge(false)
            }

            val notificationManager = getSystemService(Context.NOTIFICATION_MANAGER_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        // TODO: Cleanup WebRTC connections
    }
}
