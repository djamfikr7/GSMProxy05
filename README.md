# ProxyGSM Android Agent

Android Agent application for the ProxyGSM remote control system.

## Features
- Phone Number Authentication (Firebase)
- Background Service (Foreground Service)
- WebRTC P2P Connection
- Screen Mirroring & Remote Control
- SMS & Call Management
- File Access

## Requirements
- Android 10+ (API 29)
- Firebase Project with Phone Auth enabled

## Setup
1. Add `google-services.json` from Firebase Console to `app/`
2. Build and install on target device
3. Grant all permissions
4. Sign in with phone number
5. Service runs in background

## Privacy
- Service runs with minimal notification
- All connections are end-to-end encrypted
- No data stored in cloud (except Firebase Auth)
