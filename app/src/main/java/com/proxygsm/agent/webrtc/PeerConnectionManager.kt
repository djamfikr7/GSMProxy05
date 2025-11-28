package com.proxygsm.agent.webrtc

import android.content.Context
import android.util.Log
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.webrtc.*

/**
 * Manages WebRTC PeerConnection for P2P communication
 * Handles video/audio streaming and data channels
 */
class PeerConnectionManager(
    private val context: Context,
    private val signalingClient: SignalingClient
) {
    private var peerConnection: PeerConnection? = null
    private var dataChannel: DataChannel? = null
    private val scope = CoroutineScope(Dispatchers.IO)
    
    companion object {
        private const val TAG = "PeerConnectionManager"
        private val STUN_SERVERS = listOf(
            "stun:stun.l.google.com:19302",
            "stun:stun1.l.google.com:19302"
        )
    }
    
    private val peerConnectionObserver = object : PeerConnection.Observer {
        override fun onIceCandidate(candidate: IceCandidate) {
            Log.d(TAG, "onIceCandidate: ${candidate.sdp}")
            scope.launch {
                signalingClient.sendIceCandidate(
                    candidate.sdp,
                    candidate.sdpMid,
                    candidate.sdpMLineIndex
                )
            }
        }
        
        override fun onDataChannel(channel: DataChannel) {
            Log.d(TAG, "onDataChannel: ${channel.label()}")
            dataChannel = channel
            setupDataChannelObserver(channel)
        }
        
        override fun onIceConnectionChange(state: PeerConnection.IceConnectionState) {
            Log.d(TAG, "ICE Connection State: $state")
        }
        
        override fun onConnectionChange(state: PeerConnection.PeerConnectionState) {
            Log.d(TAG, "Peer Connection State: $state")
        }
        
        override fun onSignalingChange(state: PeerConnection.SignalingState) {
            Log.d(TAG, "Signaling State: $state")
        }
        
        override fun onIceConnectionReceivingChange(receiving: Boolean) {}
        override fun onIceGatheringChange(state: PeerConnection.IceGatheringState) {}
        override fun onAddStream(stream: MediaStream) {}
        override fun onRemoveStream(stream: MediaStream) {}
        override fun onRenegotiationNeeded() {}
        override fun onAddTrack(receiver: RtpReceiver, streams: Array<out MediaStream>) {}
    }
    
    fun initialize() {
        val options = PeerConnectionFactory.InitializationOptions.builder(context)
            .createInitializationOptions()
        PeerConnectionFactory.initialize(options)
        
        val peerConnectionFactory = PeerConnectionFactory.builder()
            .setOptions(PeerConnectionFactory.Options())
            .createPeerConnectionFactory()
        
        val iceServers = STUN_SERVERS.map { url ->
            PeerConnection.IceServer.builder(url).createIceServer()
        }
        
        val rtcConfig = PeerConnection.RTCConfiguration(iceServers).apply {
            tcpCandidatePolicy = PeerConnection.TcpCandidatePolicy.DISABLED
            bundlePolicy = PeerConnection.BundlePolicy.MAXBUNDLE
            rtcpMuxPolicy = PeerConnection.RtcpMuxPolicy.REQUIRE
            continualGatheringPolicy = PeerConnection.ContinualGatheringPolicy.GATHER_CONTINUALLY
        }
        
        peerConnection = peerConnectionFactory.createPeerConnection(
            rtcConfig,
            peerConnectionObserver
        )
        
        // Create data channel for commands
        val dataChannelInit = DataChannel.Init().apply {
            ordered = true
            negotiated = false
        }
        dataChannel = peerConnection?.createDataChannel("commands", dataChannelInit)
        setupDataChannelObserver(dataChannel!!)
        
        Log.d(TAG, "PeerConnection initialized")
    }
    
    suspend fun createOffer(): Result<SessionDescription> {
        return try {
            val constraints = MediaConstraints().apply {
                mandatory.add(MediaConstraints.KeyValuePair("OfferToReceiveVideo", "false"))
                mandatory.add(MediaConstraints.KeyValuePair("OfferToReceiveAudio", "false"))
            }
            
            val offer = peerConnection?.createOffer(constraints) ?: throw Exception("PeerConnection is null")
            peerConnection?.setLocalDescription(offer)
            
            Result.success(offer)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    suspend fun setRemoteDescription(sdp: SessionDescription): Result<Unit> {
        return try {
            peerConnection?.setRemoteDescription(sdp)
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    fun addIceCandidate(candidate: org.webrtc.IceCandidate) {
        peerConnection?.addIceCandidate(candidate)
    }
    
    private fun setupDataChannelObserver(channel: DataChannel) {
        channel.registerObserver(object : DataChannel.Observer {
            override fun onMessage(buffer: DataChannel.Buffer) {
                val data = buffer.data
                val bytes = ByteArray(data.remaining())
                data.get(bytes)
                val message = String(bytes, Charsets.UTF_8)
                
                Log.d(TAG, "Received command: $message")
                // TODO: Handle command (dial, send SMS, etc.)
            }
            
            override fun onBufferedAmountChange(amount: Long) {}
            override fun onStateChange() {
                Log.d(TAG, "DataChannel state: ${channel.state()}")
            }
        })
    }
    
    fun sendCommand(command: String) {
        val buffer = DataChannel.Buffer(
            java.nio.ByteBuffer.wrap(command.toByteArray(Charsets.UTF_8)),
            false
        )
        dataChannel?.send(buffer)
    }
    
    fun close() {
        dataChannel?.close()
        peerConnection?.close()
        Log.d(TAG, "PeerConnection closed")
    }
}

// Extension functions for coroutine support
private suspend fun PeerConnection.createOffer(constraints: MediaConstraints): SessionDescription {
    return kotlin.coroutines.suspendCoroutine { continuation ->
        createOffer(object : SdpObserver {
            override fun onCreateSuccess(sdp: SessionDescription) {
                continuation.resumeWith(Result.success(sdp))
            }
            override fun onCreateFailure(error: String) {
                continuation.resumeWith(Result.failure(Exception(error)))
            }
            override fun onSetSuccess() {}
            override fun onSetFailure(error: String) {}
        }, constraints)
    }
}

private suspend fun PeerConnection.setLocalDescription(sdp: SessionDescription) {
    kotlin.coroutines.suspendCoroutine<Unit> { continuation ->
        setLocalDescription(object : SdpObserver {
            override fun onSetSuccess() {
                continuation.resumeWith(Result.success(Unit))
            }
            override fun onSetFailure(error: String) {
                continuation.resumeWith(Result.failure(Exception(error)))
            }
            override fun onCreateSuccess(sdp: SessionDescription) {}
            override fun onCreateFailure(error: String) {}
        }, sdp)
    }
}

private suspend fun PeerConnection.setRemoteDescription(sdp: SessionDescription) {
    kotlin.coroutines.suspendCoroutine<Unit> { continuation ->
        setRemoteDescription(object : SdpObserver {
            override fun onSetSuccess() {
                continuation.resumeWith(Result.success(Unit))
            }
            override fun onSetFailure(error: String) {
                continuation.resumeWith(Result.failure(Exception(error)))
            }
            override fun onCreateSuccess(sdp: SessionDescription) {}
            override fun onCreateFailure(error: String) {}
        }, sdp)
    }
}
