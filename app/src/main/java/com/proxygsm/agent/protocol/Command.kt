package com.proxygsm.agent.protocol

import com.google.gson.Gson
import com.google.gson.annotations.SerializedName

/**
 * Command protocol for Controller -> Agent communication
 * Matches the WebSocket message format from api_documentation.md
 */
data class Command(
    @SerializedName("type")
    val type: String,
    
    @SerializedName("payload")
    val payload: Map<String, Any>,
    
    @SerializedName("id")
    val id: String,
    
    @SerializedName("timestamp")
    val timestamp: Long = System.currentTimeMillis()
) {
    companion object {
        // Command Types (from Controller)
        const val AUTH_HANDSHAKE = "AUTH_HANDSHAKE"
        const val DIAL_NUMBER = "DIAL_NUMBER"
        const val END_CALL = "END_CALL"
        const val SEND_SMS = "SEND_SMS"
        const val START_STREAM = "START_STREAM"
        const val STOP_STREAM = "STOP_STREAM"
        const val INPUT_EVENT = "INPUT_EVENT"
        const val USSD_EXEC = "USSD_EXEC"
        
        // Event Types (to Controller)
        const val DEVICE_STATUS = "DEVICE_STATUS"
        const val INCOMING_CALL = "INCOMING_CALL"
        const val CALL_STATUS = "CALL_STATUS"
        const val SMS_RECEIVED = "SMS_RECEIVED"
        const val SCREEN_FRAME = "SCREEN_FRAME"
        
        fun fromJson(json: String): Command {
            return Gson().fromJson(json, Command::class.java)
        }
    }
    
    fun toJson(): String {
        return Gson().toJson(this)
    }
}

/**
 * Input event types for remote control
 */
data class InputEvent(
    val action: String, // "tap", "swipe", "home", "back"
    val x: Float? = null,
    val y: Float? = null,
    val x2: Float? = null, // For swipe end point
    val y2: Float? = null
)
