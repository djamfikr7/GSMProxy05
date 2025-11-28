import 'package:flutter/material.dart';
import '../../../../design/tokens.dart';
import '../../../dialer/presentation/widgets/dialer_keypad.dart';

class UssdScreen extends StatefulWidget {
  const UssdScreen({super.key});

  @override
  State<UssdScreen> createState() => _UssdScreenState();
}

class _UssdScreenState extends State<UssdScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _history = ['*#06#', '*100#', '*123#'];

  void _handleDigit(String digit) {
    _controller.text += digit;
  }

  void _executeCode() {
    if (_controller.text.isEmpty) return;

    final code = _controller.text;

    // Mock USSD Response
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _UssdResponseDialog(code: code),
    );

    if (!_history.contains(code)) {
      setState(() {
        _history.insert(0, code);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('USSD Codes')),
      body: Column(
        children: [
          // Input Area
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(AppTokens.space4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _controller,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Code',
                    ),
                  ),
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.backspace_rounded),
                      onPressed: () {
                        final text = _controller.text;
                        if (text.isNotEmpty) {
                          _controller.text = text.substring(0, text.length - 1);
                        }
                      },
                    ),
                ],
              ),
            ),
          ),

          // Quick Actions / History
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppTokens.space4),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final code = _history[index];
                return Padding(
                  padding: const EdgeInsets.only(right: AppTokens.space2),
                  child: ActionChip(
                    label: Text(code),
                    onPressed: () {
                      _controller.text = code;
                    },
                    avatar: const Icon(Icons.history_rounded, size: 16),
                  ),
                );
              },
            ),
          ),

          const Divider(),

          // Keypad
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DialerKeypad(
                  onDigitPressed: _handleDigit,
                  onZeroLongPress: () => _handleDigit('+'),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppTokens.space4),
                  child: FloatingActionButton.extended(
                    onPressed: _executeCode,
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: const Icon(Icons.call_rounded),
                    label: const Text('Execute'),
                  ),
                ),
                const SizedBox(height: AppTokens.space4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UssdResponseDialog extends StatefulWidget {
  final String code;

  const _UssdResponseDialog({required this.code});

  @override
  State<_UssdResponseDialog> createState() => _UssdResponseDialogState();
}

class _UssdResponseDialogState extends State<_UssdResponseDialog> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isLoading) ...[
            const CircularProgressIndicator(),
            const SizedBox(height: AppTokens.space4),
            Text(
              'Running USSD code...\n${widget.code}',
              textAlign: TextAlign.center,
            ),
          ] else ...[
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: AppTokens.space4),
            const Text(
              'Carrier Info\n\nBalance: \$12.50\nData: 4.5 GB\nExpires: 30 days',
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
      actions: [
        if (!_isLoading)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
      ],
    );
  }
}
