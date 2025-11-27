import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/device_model.dart';
import '../../models/call_model.dart';
import '../../models/message_model.dart';
import '../../../core/network/dio_provider.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Devices
  @GET('/devices')
  Future<List<DeviceModel>> getDevices();

  @GET('/devices/{id}')
  Future<DeviceModel> getDevice(@Path('id') String id);

  // Calls
  @GET('/calls')
  Future<List<CallModel>> getCallHistory(
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @POST('/calls')
  Future<void> initiateCall(@Body() Map<String, dynamic> body);

  @POST('/calls/{id}/answer')
  Future<void> answerCall(@Path('id') String id);

  @POST('/calls/{id}/end')
  Future<void> endCall(@Path('id') String id);

  // Messages
  @GET('/messages')
  Future<List<MessageModel>> getMessages(
    @Query('threadId') String threadId,
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @GET('/threads')
  Future<List<MessageModel>> getThreads(
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @POST('/messages')
  Future<void> sendMessage(@Body() Map<String, dynamic> body);
}

@Riverpod(keepAlive: true)
ApiService apiService(ApiServiceRef ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
}
