import '../../data/models/call_model.dart';

abstract class CallRepository {
  Future<List<CallModel>> getCallHistory({int limit = 50, int offset = 0});
  Future<void> initiateCall(String number);
  Future<void> endCall(String callId);
  Future<void> answerCall(String callId);
  Stream<CallModel?> get activeCall;
}
