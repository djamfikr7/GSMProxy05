import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../design/tokens.dart';

/// Shimmer loading skeleton for various content types
class ShimmerLoading extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const ShimmerLoading({super.key, required this.child, this.isLoading = true});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: child,
    );
  }
}

/// Shimmer skeleton for screen projection viewer
class ScreenShimmer extends StatelessWidget {
  const ScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTokens.radiusLg),
        ),
      ),
    );
  }
}

/// Shimmer skeleton for call history items
class CallHistoryShimmer extends StatelessWidget {
  const CallHistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(AppTokens.space4),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppTokens.space3),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppTokens.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(width: 100, height: 14, color: Colors.white),
                    ],
                  ),
                ),
                Container(width: 20, height: 20, color: Colors.white),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Shimmer skeleton for message threads
class MessageThreadShimmer extends StatelessWidget {
  const MessageThreadShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.all(AppTokens.space4),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppTokens.space4),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppTokens.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(width: 200, height: 14, color: Colors.white),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(width: 40, height: 12, color: Colors.white),
                    const SizedBox(height: 8),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Shimmer skeleton for contact list
class ContactListShimmer extends StatelessWidget {
  const ContactListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListView.builder(
        itemCount: 8,
        padding: const EdgeInsets.all(AppTokens.space4),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppTokens.space3),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppTokens.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 6),
                      Container(width: 120, height: 14, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
