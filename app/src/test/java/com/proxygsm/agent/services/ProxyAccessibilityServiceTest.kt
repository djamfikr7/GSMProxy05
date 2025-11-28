package com.proxygsm.agent.services

import android.content.Context
import android.view.accessibility.AccessibilityEvent
import io.mockk.*
import org.junit.After
import org.junit.Before
import org.junit.Test
import kotlin.test.assertFalse
import kotlin.test.assertNull
import kotlin.test.assertTrue

class ProxyAccessibilityServiceTest {
    
    private lateinit var service: ProxyAccessibilityService
    private lateinit var mockContext: Context
    
    @Before
    fun setup() {
        MockKAnnotations.init(this)
        mockContext = mockk(relaxed = true)
        service = ProxyAccessibilityService()
    }
    
    @After
    fun tearDown() {
        unmockkAll()
    }
    
    @Test
    fun `getInstance should return null when service not connected`() {
        // When
        val instance = ProxyAccessibilityService.getInstance()
        
        // Then
        // Note: Will be null until service is actually connected by Android system
        assertNull(instance)
    }
    
    @Test
    fun `onAccessibilityEvent should not crash with null event`() {
        // Given
        val event: AccessibilityEvent? = null
        
        // When/Then - should not throw
        service.onAccessibilityEvent(event)
    }
    
    @Test
    fun `service should handle interruption gracefully`() {
        // When/Then - should not throw
        service.onInterrupt()
    }
}
