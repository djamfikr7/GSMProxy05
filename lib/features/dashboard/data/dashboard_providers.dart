import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/device_model.dart';
import '../../../core/enums.dart';

part 'dashboard_providers.g.dart';

// Navigation state
@riverpod
class SelectedNavigationIndex extends _$SelectedNavigationIndex {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}

// Mock connected devices
@riverpod
class ConnectedDevices extends _$ConnectedDevices {
  @override
  List<DeviceModel> build() {
    return [
      const DeviceModel(
        id: 'device-1',
        name: 'Samsung Galaxy S21',
        model: 'SM-G991B',
        manufacturer: 'Samsung',
        androidVersion: '13',
        sdkVersion: 33,
        status: DeviceStatus.online,
        batteryLevel: 85,
        isCharging: false,
        signalStrength: 4,
        operatorName: 'Vodafone',
        phoneNumber: '+1 234 567 8900',
      ),
    ];
  }
}

// Mock latency
@riverpod
class ConnectionLatency extends _$ConnectionLatency {
  @override
  int build() => 42; // ms

  void update(int latency) {
    state = latency;
  }
}
