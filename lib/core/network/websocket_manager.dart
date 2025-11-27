import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'network_config.dart';

part 'websocket_manager.g.dart';

enum WebSocketStatus { disconnected, connecting, connected, error }

@Riverpod(keepAlive: true)
class WebSocketManager extends _$WebSocketManager {
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;

  @override
  Stream<WebSocketStatus> build() {
    // Initial status
    return Stream.value(WebSocketStatus.disconnected);
  }

  void connect() {
    if (state.value == WebSocketStatus.connected ||
        state.value == WebSocketStatus.connecting) {
      return;
    }

    state = const AsyncValue.data(WebSocketStatus.connecting);

    try {
      _channel = WebSocketChannel.connect(Uri.parse(NetworkConfig.wsUrl));

      // Listen to the stream to ensure connection is established
      _channel!.stream.listen(
        (message) {
          // Handle incoming messages (can be broadcasted via another provider)
          debugPrint('WS Message: $message');
        },
        onDone: () {
          state = const AsyncValue.data(WebSocketStatus.disconnected);
          _scheduleReconnect();
        },
        onError: (error) {
          state = const AsyncValue.data(WebSocketStatus.error);
          _scheduleReconnect();
        },
      );

      state = const AsyncValue.data(WebSocketStatus.connected);
      _reconnectTimer?.cancel();
    } catch (e) {
      state = const AsyncValue.data(WebSocketStatus.error);
      _scheduleReconnect();
    }
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _channel?.sink.close(status.goingAway);
    _channel = null;
    state = const AsyncValue.data(WebSocketStatus.disconnected);
  }

  void send(Map<String, dynamic> data) {
    if (state.value == WebSocketStatus.connected && _channel != null) {
      _channel!.sink.add(jsonEncode(data));
    } else {
      debugPrint('WS Error: Cannot send, not connected');
    }
  }

  void _scheduleReconnect() {
    if (_reconnectTimer?.isActive ?? false) return;

    debugPrint(
      'WS: Scheduling reconnect in ${NetworkConfig.reconnectInterval.inSeconds}s',
    );
    _reconnectTimer = Timer(NetworkConfig.reconnectInterval, () {
      connect();
    });
  }
}
