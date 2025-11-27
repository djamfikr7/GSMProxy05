# GSMProxy05

Premium Flutter-based remote proxy system for Android devices with real-time screen streaming, call management, and messaging capabilities.

## Features

### ✅ Phase 1-5 Complete

- **🎨 Design System**: Material 3 with glassmorphism, custom tokens, Inter typography
- **🔐 Authentication Flow**: Splash → Permissions → QR Scanner → Biometric → Dashboard
- **📱 Adaptive Dashboard**: Responsive layout (mobile/tablet/desktop) with navigation rail
- **📺 Screen Projection**: Real-time viewer with gesture overlay, stats, and InteractiveViewer
- **📞 Dialer** (Partial): Premium DTMF keypad with smooth animations and number formatting

### 🚧 In Progress

- **Phase 6**: Active call screen, call history, audio visualizer
- **Phase 7**: Messaging system
- **Phase 8+**: Advanced features

## Tech Stack

- **Framework**: Flutter 3.9+
- **State Management**: Riverpod 2.6+
- **Networking**: Dio + Retrofit + WebSocket
- **Storage**: flutter_secure_storage
- **UI**: Material 3 + Custom Design System
- **Typography**: Google Fonts (Inter)
- **Code Generation**: build_runner, freezed, riverpod_generator

## Getting Started

### Prerequisites

- Flutter SDK 3.9 or higher
- Dart SDK 3.0 or higher

### Installation

```bash
# Install dependencies
flutter pub get

# Generate code
dart run build_runner build --delete-conflicting-outputs

# Run on web (development)
flutter run -d chrome --web-port=9090

# Run on mobile
flutter run
```

## Project Structure

```
lib/
├── components/          # Reusable UI components (GlassCard, etc.)
├── core/               # Core utilities (network, storage)
├── data/               # Data models
├── design/             # Design tokens, theme
├── features/           # Feature modules
│   ├── auth/          # Authentication & onboarding
│   ├── dashboard/     # Main dashboard
│   ├── dialer/        # Call management
│   └── screen/        # Screen projection
└── main.dart          # App entry point
```

## Design Principles

- **shadCN-inspired**: Glass cards, subtle gradients, premium aesthetics
- **Material 3**: Dynamic colors, elevation, state layers
- **Micro-animations**: Smooth transitions, button feedback (60fps)
- **Responsive**: Mobile-first, adapts to all screen sizes
- **Performance**: Optimized animations, efficient rendering

## Development

### Running Code Generation

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Running Tests

```bash
flutter test
```

## License

Copyright © 2025. All rights reserved.
