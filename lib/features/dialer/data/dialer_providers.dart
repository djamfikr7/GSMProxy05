import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dialer_providers.g.dart';

/// Manages the phone number being dialed
@riverpod
class DialerNumber extends _$DialerNumber {
  @override
  String build() => '';

  void addDigit(String digit) {
    state = state + digit;
  }

  void removeLastDigit() {
    if (state.isNotEmpty) {
      state = state.substring(0, state.length - 1);
    }
  }

  void clear() {
    state = '';
  }

  void setNumber(String number) {
    state = number;
  }
}

/// Formats phone number for display
String formatPhoneNumber(String number) {
  if (number.isEmpty) return '';

  // Remove all non-digit characters
  final digits = number.replaceAll(RegExp(r'\D'), '');

  if (digits.length <= 3) {
    return digits;
  } else if (digits.length <= 6) {
    return '(${digits.substring(0, 3)}) ${digits.substring(3)}';
  } else if (digits.length <= 10) {
    return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
  } else {
    return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6, 10)}';
  }
}
