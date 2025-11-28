package com.proxygsm.agent.services

import android.app.*
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.google.firebase.auth.FirebaseAuth
import com.proxygsm.agent.MainActivity
import com.proxygsm.agent.R
import com.proxygsm.agent.features.sms.SmsManagerWrapper
import com.proxygsm.agent.features.telephony.TelephonyManagerWrapper
import com.proxygsm.agent.protocol.Command
import com.proxygsm.agent.protocol.InputEvent
import com.proxygsm.agent.receivers.PhoneStateReceiver
import com.proxygsm.agent.webrtc.PeerConnectionManager
import com.proxygsm.agent.webrtc.SignalingClient
import com.google.gson.Gson
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.collect

class ProxyService : Service() {
    
    companion object {
        private const val TAG = "ProxyService"
        private const val NOTIFICATION_ID = 9090
        private const val CHANNEL_ID = "proxygsm_service"
    }

    private val scope = CoroutineScope(Dispatchers.Main + SupervisorJob())
    private lateinit var signalingClient: SignalingClient
    private lateinit var peerConnectionManager: PeerConnectionManager
    private lateinit var telephonyManager: TelephonyManagerWrapper
    private lateinit var smsManager: SmsManagerWrapper
    
    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        initializeComponents()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startForeground(NOTIFICATION_ID, createNotification())
        
        // Start WebRTC connection
        scope.launch {
            connectToController()
        }
        
        // Monitor call state changes
        scope.launch {
            telephonyManager.callState.collect { callState ->
                // TODO: Send call state to Controller
                Log.d(TAG, "Call state changed: $callState")
            }
        }
        
        // Monitor incoming SMS
        scope.launch {
            smsManager.incomingSms.collect { sms ->
                // TODO: Send SMS to Controller
                Log.d(TAG, "SMS received: ${sms.from}")
            }
        }
        
        return START_STICKY
    }

    private fun initializeComponents() {
        val userId = FirebaseAuth.getInstance().currentUser?.uid ?: "anonymous"
        signalingClient = SignalingClient(userId)
        peerConnectionManager = PeerConnectionManager(this, signalingClient)
        telephonyManager = TelephonyManagerWrapper(this)
        smsManager = SmsManagerWrapper.getInstance(this)
        
        // Register telephony manager with receiver
        PhoneStateReceiver.setTelephonyManager(telephonyManager)
        
        Log.d(TAG, "Components initialized")
    }
    
    private suspend fun connectToController() {
        try {
            // Initialize WebRTC
            peerConnectionManager.initialize()
            
            // Create and send offer
            val offer = peerConnectionManager.createOffer().getOrThrow()
            signalingClient.sendOffer(offer)
            
            Log.d(TAG, "WebRTC offer sent")
            
            // Listen for answer
            signalingClient.listenForAnswer().collect { answer ->
                peerConnectionManager.setRemoteDescription(answer)
                Log.d(TAG, "WebRTC connection established")
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error connecting to Controller", e)
        }
    }
    
    /**
     * Handle incoming command from Controller
     */
    private fun handleCommand(json: String) {
        try {
            val command = Command.fromJson(json)
            Log.d(TAG, "Command received: ${command.type}")
            
            when (command.type) {
                Command.DIAL_NUMBER -> {
                    val number = command.payload["number"] as? String
                    number?.let { telephonyManager.makeCall(it) }
                }
                
                Command.END_CALL -> {
                    telephonyManager.endCall()
                }
                
                Command.SEND_SMS -> {
                    val to = command.payload["to"] as? String
                    val body = command.payload["body"] as? String
                    if (to != null && body != null) {
                        smsManager.sendSms(to, body)
                    }
                }
                
                Command.INPUT_EVENT -> {
                    val inputJson = Gson().toJson(command.payload)
                    val input = Gson().fromJson(inputJson, InputEvent::class.java)
                    handleInputEvent(input)
                }
                
                Command.START_STREAM -> {
                    // TODO: Start ScreenCaptureService
                    Log.d(TAG, "Start screen stream")
                }
                
                Command.STOP_STREAM -> {
                    // TODO: Stop ScreenCaptureService
                    Log.d(TAG, "Stop screen stream")
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error handling command", e)
        }
    }
    
    private fun handleInputEvent(input: InputEvent) {
        val accessibilityService = ProxyAccessibilityService.getInstance()
        
        if (accessibilityService == null) {
            Log.e(TAG, "Accessibility service not available")
            return
        }
        
        when (input.action) {
            "tap" -> {
                if (input.x != null && input.y != null) {
                    accessibilityService.performTap(input.x, input.y)
                }
            }
            "swipe" -> {
                if (input.x != null && input.y != null && input.x2 != null && input.y2 != null) {
                    accessibilityService.performSwipe(input.x, input.y, input.x2, input.y2)
                }
            }
            "home" -> accessibilityService.goHome()
            "back" -> accessibilityService.goBack()
        }
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
        scope.cancel()
        peerConnectionManager.close()
        Log.d(TAG, "ProxyService destroyed")
    }
}
