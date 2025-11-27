import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:gsm05/data/datasources/remote/api_service.dart';
import 'package:gsm05/data/repositories/device_repository_impl.dart';
import 'package:gsm05/data/models/device_model.dart';
import 'device_repository_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late DeviceRepositoryImpl repository;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    repository = DeviceRepositoryImpl(mockApiService);
  });

  group('DeviceRepository', () {
    const tDevice = DeviceModel(
      id: '1',
      name: 'Pixel 7',
      model: 'Pixel 7',
      manufacturer: 'Google',
      androidVersion: '13',
      sdkVersion: 33,
    );

    test(
      'should return list of devices when call to remote data source is successful',
      () async {
        // Arrange
        when(mockApiService.getDevices()).thenAnswer((_) async => [tDevice]);

        // Act
        final result = await repository.getDevices();

        // Assert
        expect(result, equals([tDevice]));
        verify(mockApiService.getDevices());
        verifyNoMoreInteractions(mockApiService);
      },
    );
  });
}
