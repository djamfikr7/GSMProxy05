import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/enums.dart';
import '../../domain/repositories/device_repository.dart';
import '../datasources/remote/api_service.dart';
import '../models/device_model.dart';

part 'device_repository_impl.g.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final ApiService _apiService;

  DeviceRepositoryImpl(this._apiService);

  @override
  Future<DeviceModel> getDevice(String id) {
    return _apiService.getDevice(id);
  }

  @override
  Future<List<DeviceModel>> getDevices() {
    return _apiService.getDevices();
  }

  @override
  Future<void> updateDeviceStatus(String id, DeviceStatus status) {
    // TODO: Implement update status via API or WS
    throw UnimplementedError();
  }

  @override
  Stream<DeviceModel> watchDevice(String id) {
    // TODO: Implement WebSocket stream for device updates
    return const Stream.empty();
  }
}

@Riverpod(keepAlive: true)
DeviceRepository deviceRepository(DeviceRepositoryRef ref) {
  final apiService = ref.watch(apiServiceProvider);
  return DeviceRepositoryImpl(apiService);
}
