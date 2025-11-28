package com.proxygsm.agent.features.telephony

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.telecom.TelecomManager
import android.telephony.TelephonyManager
import android.util.Log
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow

/**
 * Manages telephony operations (calls, SIM info)
 */
class TelephonyManagerWrapper(private val context: Context) {
    
    private val telephonyManager = context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
    private val telecomManager = context.getSystemService(Context.TELECOM_SERVICE) as TelecomManager
    
    private val _callState = MutableStateFlow<CallState>(CallState.Idle)
    val callState: StateFlow<CallState> = _callState
    
    companion object {
        private const val TAG = "TelephonyManagerWrapper"
    }
    
    /**
     * Initiate an outgoing call
     */
    fun makeCall(phoneNumber: String): Result<Unit> {
        return try {
            val intent = Intent(Intent.ACTION_CALL).apply {
                data = Uri.parse("tel:$phoneNumber")
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            context.startActivity(intent)
            
            Log.d(TAG, "Call initiated to $phoneNumber")
            Result.success(Unit)
        } catch (e: Exception) {
            Log.e(TAG, "Error making call", e)
            Result.failure(e)
        }
    }
    
    /**
     * End ongoing call (requires Accessibility Service)
     */
    fun endCall(): Result<Unit> {
        return try {
            val accessibilityService = com.proxygsm.agent.services.ProxyAccessibilityService.getInstance()
            
            if (accessibilityService != null) {
                // Simulate "End Call" button press via accessibility
                accessibilityService.goBack() // Simple approach
                Log.d(TAG, "Call ended")
                Result.success(Unit)
            } else {
                Result.failure(Exception("Accessibility service not available"))
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error ending call", e)
            Result.failure(e)
        }
    }
    
    /**
     * Get SIM card information
     */
    fun getSimInfo(): SimInfo {
        val operatorName = telephonyManager.networkOperatorName
        val phoneNumber = try {
            telephonyManager.line1Number
        } catch (e: SecurityException) {
            "Unknown"
        }
        
        return SimInfo(
            operatorName = operatorName ?: "Unknown",
            phoneNumber = phoneNumber ?: "Unknown",
            simState = telephonyManager.simState
        )
    }
    
    /**
     * Update call state (called by PhoneStateReceiver)
     */
    fun updateCallState(state: CallState) {
        _callState.value = state
        Log.d(TAG, "Call state updated: $state")
    }
}

data class SimInfo(
    val operatorName: String,
    val phoneNumber: String,
    val simState: Int
)

sealed class CallState {
    object Idle : CallState()
    data class Ringing(val phoneNumber: String) : CallState()
    data class Active(val phoneNumber: String) : CallState()
    object Ended : CallState()
}
