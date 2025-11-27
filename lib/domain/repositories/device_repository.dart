import '../../core/enums.dart';
import '../../data/models/device_model.dart';

abstract class DeviceRepository {
  Future<DeviceModel> getDevice(String id);
  Future<List<DeviceModel>> getDevices();
  Future<void> updateDeviceStatus(String id, DeviceStatus status);
  Stream<DeviceModel> watchDevice(String id);
}
