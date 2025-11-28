package com.proxygsm.agent.services

import android.app.*
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.hardware.display.DisplayManager
import android.hardware.display.VirtualDisplay
import android.media.MediaCodec
import android.media.MediaCodecInfo
import android.media.MediaFormat
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.IBinder
import android.util.DisplayMetrics
import android.util.Log
import android.view.Surface
import android.view.WindowManager
import androidx.core.app.NotificationCompat
import com.proxygsm.agent.MainActivity
import com.proxygsm.agent.R
import java.nio.ByteBuffer

/**
 * Service for capturing screen and encoding to H.264
 * Runs as foreground service with MediaProjection permission
 */
class ScreenCaptureService : Service() {
    
    private var mediaProjection: MediaProjection? = null
    private var virtualDisplay: VirtualDisplay? = null
    private var mediaCodec: MediaCodec? = null
    private var surface: Surface? = null
    
    private var screenWidth = 1080
    private var screenHeight = 1920
    private var screenDensity = DisplayMetrics.DENSITY_HIGH
    
    companion object {
        private const val TAG = "ScreenCaptureService"
        private const val NOTIFICATION_ID = 9091
        private const val CHANNEL_ID = "screen_capture_service"
        const val EXTRA_RESULT_CODE = "result_code"
        const val EXTRA_RESULT_DATA = "result_data"
        
        // Video encoding parameters
        private const val BIT_RATE = 2000000 // 2 Mbps
        private const val FRAME_RATE = 30
        private const val I_FRAME_INTERVAL = 2 // seconds
    }
    
    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        getScreenDimensions()
    }
    
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startForeground(NOTIFICATION_ID, createNotification())
        
        intent?.let {
            val resultCode = it.getIntExtra(EXTRA_RESULT_CODE, Activity.RESULT_CANCELED)
            val resultData: Intent? = it.getParcelableExtra(EXTRA_RESULT_DATA)
            
            if (resultCode == Activity.RESULT_OK && resultData != null) {
                startScreenCapture(resultCode, resultData)
            }
        }
        
        return START_STICKY
    }
    
    override fun onBind(intent: Intent?): IBinder? = null
    
    private fun getScreenDimensions() {
        val windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val displayMetrics = DisplayMetrics()
        
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            display?.getRealMetrics(displayMetrics)
        } else {
            @Suppress("DEPRECATION")
            windowManager.defaultDisplay.getRealMetrics(displayMetrics)
        }
        
        screenWidth = displayMetrics.widthPixels
        screenHeight = displayMetrics.heightPixels
        screenDensity = displayMetrics.densityDpi
        
        Log.d(TAG, "Screen: ${screenWidth}x${screenHeight} @ ${screenDensity}dpi")
    }
    
    private fun startScreenCapture(resultCode: Int, resultData: Intent) {
        val projectionManager = getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        mediaProjection = projectionManager.getMediaProjection(resultCode, resultData)
        
        if (mediaProjection == null) {
            Log.e(TAG, "MediaProjection is null")
            stopSelf()
            return
        }
        
        setupMediaCodec()
        createVirtualDisplay()
    }
    
    private fun setupMediaCodec() {
        try {
            val format = MediaFormat.createVideoFormat(
                MediaFormat.MIMETYPE_VIDEO_AVC,
                screenWidth,
                screenHeight
            ).apply {
                setInteger(MediaFormat.KEY_COLOR_FORMAT, MediaCodecInfo.CodecCapabilities.COLOR_FormatSurface)
                setInteger(MediaFormat.KEY_BIT_RATE, BIT_RATE)
                setInteger(MediaFormat.KEY_FRAME_RATE, FRAME_RATE)
                setInteger(MediaFormat.KEY_I_FRAME_INTERVAL, I_FRAME_INTERVAL)
            }
            
            mediaCodec = MediaCodec.createEncoderByType(MediaFormat.MIMETYPE_VIDEO_AVC).apply {
                configure(format, null, null, MediaCodec.CONFIGURE_FLAG_ENCODE)
                surface = createInputSurface()
                start()
            }
            
            // Start encoder thread
            Thread { encodeLoop() }.start()
            
            Log.d(TAG, "MediaCodec started")
        } catch (e: Exception) {
            Log.e(TAG, "Error setting up MediaCodec", e)
        }
    }
    
    private fun createVirtualDisplay() {
        virtualDisplay = mediaProjection?.createVirtualDisplay(
            "ScreenCapture",
            screenWidth,
            screenHeight,
            screenDensity,
            DisplayManager.VIRTUAL_DISPLAY_FLAG_AUTO_MIRROR,
            surface,
            null,
            null
        )
        
        Log.d(TAG, "VirtualDisplay created")
    }
    
    private fun encodeLoop() {
        val bufferInfo = MediaCodec.BufferInfo()
        
        while (mediaCodec != null) {
            try {
                val outputBufferId = mediaCodec?.dequeueOutputBuffer(bufferInfo, 10000) ?: continue
                
                if (outputBufferId >= 0) {
                    val outputBuffer = mediaCodec?.getOutputBuffer(outputBufferId)
                    
                    if (outputBuffer != null && bufferInfo.size > 0) {
                        // Extract H.264 data
                        val data = ByteArray(bufferInfo.size)
                        outputBuffer.get(data)
                        
                        // TODO: Send to WebRTC via PeerConnectionManager
                        // For now, just log
                        if ((bufferInfo.flags and MediaCodec.BUFFER_FLAG_KEY_FRAME) != 0) {
                            Log.d(TAG, "Key frame: ${data.size} bytes")
                        }
                    }
                    
                    mediaCodec?.releaseOutputBuffer(outputBufferId, false)
                }
                
                if ((bufferInfo.flags and MediaCodec.BUFFER_FLAG_END_OF_STREAM) != 0) {
                    break
                }
            } catch (e: Exception) {
                Log.e(TAG, "Encoding error", e)
                break
            }
        }
    }
    
    private fun createNotification(): Notification {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this, 0, notificationIntent,
            PendingIntent.FLAG_IMMUTABLE
        )
        
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Screen Sharing")
            .setContentText("Sharing screen...")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentIntent(pendingIntent)
            .setPriority(NotificationCompat.PRIORITY_MIN)
            .setOngoing(true)
            .build()
    }
    
    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Screen Capture",
                NotificationManager.IMPORTANCE_MIN
            ).apply {
                description = "Screen capture service"
                setShowBadge(false)
            }
            
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }
    
    override fun onDestroy() {
        super.onDestroy()
        stopScreenCapture()
    }
    
    private fun stopScreenCapture() {
        virtualDisplay?.release()
        virtualDisplay = null
        
        surface?.release()
        surface = null
        
        mediaCodec?.stop()
        mediaCodec?.release()
        mediaCodec = null
        
        mediaProjection?.stop()
        mediaProjection = null
        
        Log.d(TAG, "Screen capture stopped")
    }
}
