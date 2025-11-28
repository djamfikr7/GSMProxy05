package com.proxygsm.agent.webrtc

import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.ListenerRegistration
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.tasks.await
import org.webrtc.SessionDescription

/**
 * Handles WebRTC signaling via Firestore
 * Uses a document-based approach for SDP offer/answer exchange
 */
class SignalingClient(private val userId: String) {
    private val firestore = FirebaseFirestore.getInstance()
    private val signalingCollection = firestore.collection("signaling")
    
    /**
     * Send SDP offer to Firestore
     * Controller will pick this up and respond with an answer
     */
    suspend fun sendOffer(offer: SessionDescription): Result<Unit> {
        return try {
            val offerData = mapOf(
                "type" to offer.type.canonicalForm(),
                "sdp" to offer.description,
                "from" to userId,
                "timestamp" to System.currentTimeMillis()
            )
            
            signalingCollection
                .document(userId)
                .set(offerData)
                .await()
            
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    /**
     * Listen for SDP answer from Controller
     * Returns a Flow that emits when answer is available
     */
    fun listenForAnswer(): Flow<SessionDescription> = callbackFlow {
        val listenerRegistration: ListenerRegistration = signalingCollection
            .document(userId)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    close(error)
                    return@addSnapshotListener
                }
                
                snapshot?.let { doc ->
                    val type = doc.getString("answer_type")
                    val sdp = doc.getString("answer_sdp")
                    
                    if (type != null && sdp != null) {
                        val sdpType = when (type.lowercase()) {
                            "offer" -> SessionDescription.Type.OFFER
                            "answer" -> SessionDescription.Type.ANSWER
                            "pranswer" -> SessionDescription.Type.PRANSWER
                            else -> SessionDescription.Type.ANSWER
                        }
                        
                        trySend(SessionDescription(sdpType, sdp))
                    }
                }
            }
        
        awaitClose { listenerRegistration.remove() }
    }
    
    /**
     * Send ICE candidate to Firestore
     */
    suspend fun sendIceCandidate(candidate: String, sdpMid: String, sdpMLineIndex: Int): Result<Unit> {
        return try {
            val candidateData = mapOf(
                "candidate" to candidate,
                "sdpMid" to sdpMid,
                "sdpMLineIndex" to sdpMLineIndex,
                "timestamp" to System.currentTimeMillis()
            )
            
            signalingCollection
                .document(userId)
                .collection("ice_candidates")
                .add(candidateData)
                .await()
            
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
    
    /**
     * Listen for ICE candidates from Controller
     */
    fun listenForIceCandidates(): Flow<IceCandidate> = callbackFlow {
        val listenerRegistration: ListenerRegistration = signalingCollection
            .document(userId)
            .collection("controller_ice_candidates")
            .addSnapshotListener { snapshots, error ->
                if (error != null) {
                    close(error)
                    return@addSnapshotListener
                }
                
                snapshots?.documentChanges?.forEach { change ->
                    if (change.type == com.google.firebase.firestore.DocumentChange.Type.ADDED) {
                        val doc = change.document
                        val candidate = doc.getString("candidate")
                        val sdpMid = doc.getString("sdpMid")
                        val sdpMLineIndex = doc.getLong("sdpMLineIndex")?.toInt()
                        
                        if (candidate != null && sdpMid != null && sdpMLineIndex != null) {
                            trySend(IceCandidate(candidate, sdpMid, sdpMLineIndex))
                        }
                    }
                }
            }
        
        awaitClose { listenerRegistration.remove() }
    }
}

data class IceCandidate(
    val candidate: String,
    val sdpMid: String,
    val sdpMLineIndex: Int
)
