import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../design/tokens.dart';
import '../../../../components/components.dart';

class CallRecordingScreen extends StatefulWidget {
  const CallRecordingScreen({super.key});

  @override
  State<CallRecordingScreen> createState() => _CallRecordingScreenState();
}

class _CallRecordingScreenState extends State<CallRecordingScreen> {
  bool _isEnabled = false;
  int _autoDeleteDays = 30; // Default 30 days
  final List<Map<String, dynamic>> _recordings = [
    {
      'name': 'Alice Johnson',
      'date': 'Today, 10:30 AM',
      'duration': '5:23',
      'size': '2.4 MB',
    },
    {
      'name': 'Unknown Number',
      'date': 'Yesterday, 4:15 PM',
      'duration': '1:45',
      'size': '0.8 MB',
    },
    {
      'name': 'Bob Smith',
      'date': 'Nov 25, 9:00 AM',
      'duration': '12:10',
      'size': '5.6 MB',
    },
  ];

  Future<void> _toggleRecording(bool value) async {
    if (value) {
      final accepted = await showDialog<bool>(
        context: context,
        builder: (context) => const _LegalWarningDialog(),
      );

      if (accepted == true) {
        setState(() => _isEnabled = true);
      }
    } else {
      setState(() => _isEnabled = false);
    }
  }

  Future<void> _showAutoDeleteSettings() async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) => _AutoDeleteDialog(currentDays: _autoDeleteDays),
    );

    if (result != null) {
      setState(() => _autoDeleteDays = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Call Recording')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTokens.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings Card
            GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  SwitchListTile(
                    value: _isEnabled,
                    onChanged: _toggleRecording,
                    title: const Text('Enable Call Recording'),
                    subtitle: const Text(
                      'Record all incoming and outgoing calls',
                    ),
                    secondary: Icon(
                      _isEnabled ? Icons.mic_rounded : Icons.mic_off_rounded,
                      color: _isEnabled
                          ? Colors.red
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (_isEnabled) ...[
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.auto_delete_rounded),
                      title: const Text('Auto-delete recordings'),
                      subtitle: Text(
                        _autoDeleteDays == 0
                            ? 'Never delete'
                            : 'After $_autoDeleteDays days',
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: _showAutoDeleteSettings,
                    ),
                  ],
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.1, end: 0),

            const SizedBox(height: AppTokens.space6),

            // Recordings List
            Text(
              'Recent Recordings',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: AppTokens.space4),

            if (!_isEnabled && _recordings.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppTokens.space6),
                  child: Text(
                    'Enable call recording to start saving conversations.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _recordings.length,
                itemBuilder: (context, index) {
                  final recording = _recordings[index];
                  return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppTokens.space2,
                        ),
                        child: GlassCard(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.red.withOpacity(0.1),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.red,
                              ),
                            ),
                            title: Text(recording['name']),
                            subtitle: Text(
                              '${recording['date']} • ${recording['size']}',
                            ),
                            trailing: Text(
                              recording['duration'],
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              // Mock playback
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Playing recording: ${recording['name']}',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (index * 100).ms)
                      .slideX(begin: 0.1, end: 0);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _LegalWarningDialog extends StatelessWidget {
  const _LegalWarningDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning_amber_rounded,
        size: 48,
        color: Colors.orange,
      ),
      title: const Text('Legal Warning'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Call recording laws vary by jurisdiction. In many regions, it is illegal to record a call without the consent of all parties involved.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'By enabling this feature, you agree to comply with all applicable local, state, and federal laws regarding call recording.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('I Agree & Enable'),
        ),
      ],
    );
  }
}

class _AutoDeleteDialog extends StatefulWidget {
  final int currentDays;

  const _AutoDeleteDialog({required this.currentDays});

  @override
  State<_AutoDeleteDialog> createState() => _AutoDeleteDialogState();
}

class _AutoDeleteDialogState extends State<_AutoDeleteDialog> {
  late int _selectedDays;
  final List<int> _options = [7, 14, 30, 60, 90, 180];

  @override
  void initState() {
    super.initState();
    _selectedDays = widget.currentDays;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: const Icon(Icons.auto_delete_rounded, size: 48),
      title: const Text('Auto-delete Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Automatically delete recordings older than:',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ..._options.map((days) {
            return RadioListTile<int>(
              value: days,
              groupValue: _selectedDays,
              onChanged: (value) {
                setState(() => _selectedDays = value!);
              },
              title: Text('$days days'),
              contentPadding: EdgeInsets.zero,
            );
          }),
          const Divider(),
          RadioListTile<int>(
            value: 0,
            groupValue: _selectedDays,
            onChanged: (value) {
              setState(() => _selectedDays = value!);
            },
            title: const Text('Never delete'),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _selectedDays),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
