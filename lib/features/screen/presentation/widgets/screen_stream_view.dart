import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../design/tokens.dart';
import '../../data/screen_stream_provider.dart';

class ScreenStreamView extends ConsumerWidget {
  const ScreenStreamView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamAsync = ref.watch(screenStreamProvider);

    return streamAsync.when(
      data: (frame) {
        return Image.memory(
          frame.bytes,
          gaplessPlayback: true,
          fit: BoxFit.contain,
        );
      },
      loading: () => _buildLoadingState(context),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.signal_wifi_off_rounded,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: AppTokens.space4),
            Text(
              'Connection Lost',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              onPressed: () => ref.refresh(screenStreamProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    // For demo purposes, we'll show a simulated "Active" state with a placeholder
    // since we don't have a real video stream yet.
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Simulated screen content (gradient placeholder)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey[900]!, Colors.grey[800]!],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_android_rounded,
                    size: 64,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  const SizedBox(height: AppTokens.space4),
                  Text(
                    'Waiting for video stream...',
                    style: TextStyle(color: Colors.white.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),

          // Shimmer effect
          Shimmer.fromColors(
            baseColor: Colors.transparent,
            highlightColor: Colors.white.withOpacity(0.1),
            child: Container(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
