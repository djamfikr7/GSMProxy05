import 'dart:async';
import 'dart:typed_data';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/websocket_manager.dart';
import '../domain/stream_frame.dart';

part 'screen_stream_provider.g.dart';

@riverpod
class ScreenStream extends _$ScreenStream {
  StreamSubscription? _subscription;

  @override
  Stream<StreamFrame> build() {
    final wsManager = ref.watch(webSocketManagerProvider);

    // In a real app, we would subscribe to a specific channel or topic
    // For now, we'll simulate a stream if not connected, or listen to WS

    final controller = StreamController<StreamFrame>();

    // Simulate stream for demo purposes if WS is not actually sending frames
    // In production, this would be:
    // _subscription = wsManager.stream.listen((data) { ... });

    // Mock simulation:
    Timer.periodic(const Duration(milliseconds: 1000 ~/ 30), (timer) {
      // This would be where we emit frames
      // For the demo, we'll rely on the UI to show a placeholder or
      // handle the "no signal" state until we have real backend
    });

    ref.onDispose(() {
      _subscription?.cancel();
      controller.close();
    });

    return controller.stream;
  }
}

@riverpod
class StreamStats extends _$StreamStats {
  @override
  Map<String, dynamic> build() {
    return {
      'fps': 30,
      'bitrate': '2.5 Mbps',
      'latency': '42 ms',
      'resolution': '1080x1920',
    };
  }

  void updateStats(Map<String, dynamic> newStats) {
    state = {...state, ...newStats};
  }
}
