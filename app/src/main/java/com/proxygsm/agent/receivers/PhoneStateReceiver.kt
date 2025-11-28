package com.proxygsm.agent.receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager
import android.util.Log
import com.proxygsm.agent.features.telephony.CallState
import com.proxygsm.agent.features.telephony.TelephonyManagerWrapper

/**
 * Receives phone state changes (incoming calls, call state)
 */
class PhoneStateReceiver : BroadcastReceiver() {
    
    companion object {
        private const val TAG = "PhoneStateReceiver"
        private var telephonyManager: TelephonyManagerWrapper? = null
        
        fun setTelephonyManager(manager: TelephonyManagerWrapper) {
            telephonyManager = manager
        }
    }
    
    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            TelephonyManager.ACTION_PHONE_STATE_CHANGED -> {
                val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
                val phoneNumber = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)
                
                when (state) {
                    TelephonyManager.EXTRA_STATE_RINGING -> {
                        Log.d(TAG, "Incoming call: $phoneNumber")
                        telephonyManager?.updateCallState(CallState.Ringing(phoneNumber ?: "Unknown"))
                    }
                    TelephonyManager.EXTRA_STATE_OFFHOOK -> {
                        Log.d(TAG, "Call active")
                        telephonyManager?.updateCallState(CallState.Active(phoneNumber ?: "Unknown"))
                    }
                    TelephonyManager.EXTRA_STATE_IDLE -> {
                        Log.d(TAG, "Call ended")
                        telephonyManager?.updateCallState(CallState.Ended)
                    }
                }
            }
            Intent.ACTION_NEW_OUTGOING_CALL -> {
                val phoneNumber = intent.getStringExtra(Intent.EXTRA_PHONE_NUMBER)
                Log.d(TAG, "Outgoing call: $phoneNumber")
                telephonyManager?.updateCallState(CallState.Active(phoneNumber ?: "Unknown"))
            }
        }
    }
}
