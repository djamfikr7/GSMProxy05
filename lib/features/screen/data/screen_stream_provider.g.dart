// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_stream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$screenStreamHash() => r'5a2ae27f1c3f5561e90b5af5943106d5fe240e76';

/// See also [ScreenStream].
@ProviderFor(ScreenStream)
final screenStreamProvider =
    AutoDisposeStreamNotifierProvider<ScreenStream, StreamFrame>.internal(
  ScreenStream.new,
  name: r'screenStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$screenStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ScreenStream = AutoDisposeStreamNotifier<StreamFrame>;
String _$streamStatsHash() => r'ec0f00301768497d1e9b7c89576c6c8030f29884';

/// See also [StreamStats].
@ProviderFor(StreamStats)
final streamStatsProvider =
    AutoDisposeNotifierProvider<StreamStats, Map<String, dynamic>>.internal(
  StreamStats.new,
  name: r'streamStatsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$streamStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StreamStats = AutoDisposeNotifier<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
