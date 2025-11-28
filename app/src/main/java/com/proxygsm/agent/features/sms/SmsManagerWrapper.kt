package com.proxygsm.agent.features.sms

import android.content.Context
import android.telephony.SmsManager
import android.util.Log
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.SharedFlow

/**
 * Manages SMS operations
 */
class SmsManagerWrapper(private val context: Context) {
    
    private val smsManager = SmsManager.getDefault()
    private val _incomingSms = MutableSharedFlow<SmsMessage>()
    val incomingSms: SharedFlow<SmsMessage> = _incomingSms
    
    companion object {
        private const val TAG = "SmsManagerWrapper"
        private var instance: SmsManagerWrapper? = null
        
        fun getInstance(context: Context): SmsManagerWrapper {
            if (instance == null) {
                instance = SmsManagerWrapper(context.applicationContext)
            }
            return instance!!
        }
    }
    
    /**
     * Send SMS message
     */
    fun sendSms(phoneNumber: String, message: String): Result<Unit> {
        return try {
            smsManager.sendTextMessage(phoneNumber, null, message, null, null)
            Log.d(TAG, "SMS sent to $phoneNumber")
            Result.success(Unit)
        } catch (e: Exception) {
            Log.e(TAG, "Error sending SMS", e)
            Result.failure(e)
        }
    }
    
    /**
     * Called by SmsReceiver when new SMS arrives
     */
    suspend fun handleIncomingSms(from: String, body: String) {
        val sms = SmsMessage(from, body, System.currentTimeMillis())
        _incomingSms.emit(sms)
        Log.d(TAG, "Incoming SMS from $from")
    }
}

data class SmsMessage(
    val from: String,
    val body: String,
    val timestamp: Long
)
