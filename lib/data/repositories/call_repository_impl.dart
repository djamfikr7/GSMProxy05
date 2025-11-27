import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/repositories/call_repository.dart';
import '../datasources/remote/api_service.dart';
import '../models/call_model.dart';

part 'call_repository_impl.g.dart';

class CallRepositoryImpl implements CallRepository {
  final ApiService _apiService;

  CallRepositoryImpl(this._apiService);

  @override
  Future<List<CallModel>> getCallHistory({int limit = 50, int offset = 0}) {
    return _apiService.getCallHistory(limit, offset);
  }

  @override
  Future<void> initiateCall(String number) {
    return _apiService.initiateCall({'number': number});
  }

  @override
  Future<void> endCall(String callId) {
    return _apiService.endCall(callId);
  }

  @override
  Future<void> answerCall(String callId) {
    return _apiService.answerCall(callId);
  }

  @override
  Stream<CallModel?> get activeCall {
    // TODO: Implement WebSocket stream for active call
    return const Stream.empty();
  }
}

@Riverpod(keepAlive: true)
CallRepository callRepository(CallRepositoryRef ref) {
  final apiService = ref.watch(apiServiceProvider);
  return CallRepositoryImpl(apiService);
}
