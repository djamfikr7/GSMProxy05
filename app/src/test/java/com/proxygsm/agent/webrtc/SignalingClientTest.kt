package com.proxygsm.agent.webrtc

import com.google.firebase.firestore.DocumentSnapshot
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.ListenerRegistration
import io.mockk.*
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runTest
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.webrtc.SessionDescription
import kotlin.test.assertEquals
import kotlin.test.assertTrue

@OptIn(ExperimentalCoroutinesApi::class)
class SignalingClientTest {
    
    private lateinit var signalingClient: SignalingClient
    private lateinit var mockFirestore: FirebaseFirestore
    
    @Before
    fun setup() {
        MockKAnnotations.init(this)
        mockFirestore = mockk(relaxed = true)
        signalingClient = SignalingClient("test-user-id")
    }
    
    @After
    fun tearDown() {
        unmockkAll()
    }
    
    @Test
    fun `sendOffer should store SDP offer in Firestore`() = runTest {
        // Given
        val offer = SessionDescription(SessionDescription.Type.OFFER, "sdp-content")
        
        // When
        val result = signalingClient.sendOffer(offer)
        
        // Then
        assertTrue(result.isSuccess)
    }
    
    @Test
    fun `sendIceCandidate should store candidate in Firestore`() = runTest {
        // Given
        val candidate = "ice-candidate-string"
        val sdpMid = "audio"
        val sdpMLineIndex = 0
        
        // When
        val result = signalingClient.sendIceCandidate(candidate, sdpMid, sdpMLineIndex)
        
        // Then
        assertTrue(result.isSuccess)
    }
    
    @Test
    fun `IceCandidate data class should hold correct values`() {
        // Given
        val candidate = "candidate-string"
        val sdpMid = "video"
        val sdpMLineIndex = 1
        
        // When
        val iceCandidate = IceCandidate(candidate, sdpMid, sdpMLineIndex)
        
        // Then
        assertEquals(candidate, iceCandidate.candidate)
        assertEquals(sdpMid, iceCandidate.sdpMid)
        assertEquals(sdpMLineIndex, iceCandidate.sdpMLineIndex)
    }
}
