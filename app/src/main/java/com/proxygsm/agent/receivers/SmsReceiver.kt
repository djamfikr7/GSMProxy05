package com.proxygsm.agent.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.provider.Telephony
import android.util.Log
import com.proxygsm.agent.features.sms.SmsManagerWrapper
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

/**
 * Receives incoming SMS messages
 */
class SmsReceiver : BroadcastReceiver() {
    
    companion object {
        private const val TAG = "SmsReceiver"
    }
    
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Telephony.Sms.Intents.SMS_RECEIVED_ACTION) {
            val messages = Telephony.Sms.Intents.getMessagesFromIntent(intent)
            
            messages.forEach { message ->
                val from = message.displayOriginatingAddress
                val body = message.messageBody
                
                Log.d(TAG, "SMS received from $from")
                
                // Forward to SmsManagerWrapper
                val smsManager = SmsManagerWrapper.getInstance(context)
                CoroutineScope(Dispatchers.IO).launch {
                    smsManager.handleIncomingSms(from, body)
                }
            }
        }
    }
}
