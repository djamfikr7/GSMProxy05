import 'package:flutter/material.dart';
import 'dialer_button.dart';

/// Premium DTMF keypad with smooth animations
class DialerKeypad extends StatelessWidget {
  final Function(String) onDigitPressed;
  final VoidCallback? onZeroLongPress;

  const DialerKeypad({
    super.key,
    required this.onDigitPressed,
    this.onZeroLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow(['1', '2', '3'], [null, 'ABC', 'DEF']),
          const SizedBox(height: 16),
          _buildRow(['4', '5', '6'], ['GHI', 'JKL', 'MNO']),
          const SizedBox(height: 16),
          _buildRow(['7', '8', '9'], ['PQRS', 'TUV', 'WXYZ']),
          const SizedBox(height: 16),
          _buildRow(['*', '0', '#'], [null, '+', null]),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> digits, List<String?> letters) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        final digit = digits[index];
        return DialerButton(
          digit: digit,
          letters: letters[index],
          onTap: () => onDigitPressed(digit),
          onLongPress: digit == '0' ? onZeroLongPress : null,
        );
      }),
    );
  }
}
