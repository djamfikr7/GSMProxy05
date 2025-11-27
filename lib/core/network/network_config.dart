class NetworkConfig {
  static const String wsUrl = 'ws://localhost:8080/ws'; // Default local dev URL
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration reconnectInterval = Duration(seconds: 5);
}
