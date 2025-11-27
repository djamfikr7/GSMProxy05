import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../design/tokens.dart';
import '../widgets/screen_stream_view.dart';
import '../widgets/touch_overlay.dart';
import '../../data/screen_stream_provider.dart';

class ScreenViewerScreen extends ConsumerStatefulWidget {
  const ScreenViewerScreen({super.key});

  @override
  ConsumerState<ScreenViewerScreen> createState() => _ScreenViewerScreenState();
}

class _ScreenViewerScreenState extends ConsumerState<ScreenViewerScreen> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(streamStatsProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Remote Screen',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _transformationController.value = Matrix4.identity();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // TODO: Show stream settings
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Interactive Viewer for Pan/Zoom
          InteractiveViewer(
            transformationController: _transformationController,
            minScale: 1.0,
            maxScale: 4.0,
            child: Center(
              child: AspectRatio(
                aspectRatio: 9 / 16, // Assuming portrait for now
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // The Video Stream
                    const ScreenStreamView(),

                    // The Touch Overlay
                    TouchOverlay(
                      onTap: (position) {
                        // Send tap to backend
                        print('Tap at $position');
                      },
                      onLongPress: (position) {
                        // Send long press to backend
                        print('Long press at $position');
                      },
                      onPanUpdate: (details) {
                        // Send drag to backend
                        // print('Drag at ${details.localPosition}');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Stats Overlay
          Positioned(
            top: 100,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FPS: ${stats['fps']}',
                    style: const TextStyle(color: Colors.green, fontSize: 12),
                  ),
                  Text(
                    'Bitrate: ${stats['bitrate']}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    'Latency: ${stats['latency']}',
                    style: const TextStyle(color: Colors.yellow, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
