import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../design/tokens.dart';
import '../../../../components/components.dart';

class RemoteFilesScreen extends StatefulWidget {
  const RemoteFilesScreen({super.key});

  @override
  State<RemoteFilesScreen> createState() => _RemoteFilesScreenState();
}

class _RemoteFilesScreenState extends State<RemoteFilesScreen> {
  // Mock file system
  final List<String> _breadcrumbs = ['Internal Storage'];

  final List<Map<String, dynamic>> _currentFiles = [
    {'name': 'DCIM', 'type': 'folder', 'items': 124, 'date': 'Today'},
    {'name': 'Downloads', 'type': 'folder', 'items': 45, 'date': 'Yesterday'},
    {'name': 'Documents', 'type': 'folder', 'items': 12, 'date': 'Nov 20'},
    {'name': 'Music', 'type': 'folder', 'items': 89, 'date': 'Nov 15'},
    {'name': 'Pictures', 'type': 'folder', 'items': 230, 'date': 'Nov 10'},
    {
      'name': 'report_final.pdf',
      'type': 'file',
      'size': '2.4 MB',
      'date': 'Today',
    },
    {
      'name': 'vacation_photo.jpg',
      'type': 'file',
      'size': '4.1 MB',
      'date': 'Yesterday',
    },
    {'name': 'notes.txt', 'type': 'file', 'size': '12 KB', 'date': 'Nov 22'},
  ];

  void _navigateToFolder(String folderName) {
    setState(() {
      _breadcrumbs.add(folderName);
      // In a real app, we would fetch new files here
    });
  }

  void _navigateUp() {
    if (_breadcrumbs.length > 1) {
      setState(() {
        _breadcrumbs.removeLast();
      });
    } else {
      Navigator.pop(context);
    }
  }

  IconData _getFileIcon(String type) {
    switch (type) {
      case 'folder':
        return Icons.folder_rounded;
      case 'file':
        return Icons.insert_drive_file_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'folder':
        return Colors.amber;
      case 'file':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Files'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _navigateUp,
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.sort_rounded), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Breadcrumbs
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.space4,
              vertical: AppTokens.space2,
            ),
            color: isDark ? Colors.black12 : Colors.grey[100],
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _breadcrumbs.map((crumb) {
                  final isLast = crumb == _breadcrumbs.last;
                  return Row(
                    children: [
                      InkWell(
                        onTap: isLast
                            ? null
                            : () {
                                // Navigate back to this level
                                final index = _breadcrumbs.indexOf(crumb);
                                setState(() {
                                  _breadcrumbs.removeRange(
                                    index + 1,
                                    _breadcrumbs.length,
                                  );
                                });
                              },
                        child: Text(
                          crumb,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isLast
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.primary,
                            fontWeight: isLast
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (!isLast)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 16,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

          // File List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppTokens.space4),
              itemCount: _currentFiles.length,
              itemBuilder: (context, index) {
                final file = _currentFiles[index];
                final isFolder = file['type'] == 'folder';

                return Padding(
                  padding: const EdgeInsets.only(bottom: AppTokens.space2),
                  child: GlassCard(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _getIconColor(file['type']).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getFileIcon(file['type']),
                          color: _getIconColor(file['type']),
                        ),
                      ),
                      title: Text(
                        file['name'],
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        isFolder
                            ? '${file['items']} items • ${file['date']}'
                            : '${file['size']} • ${file['date']}',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert_rounded),
                        onPressed: () {},
                      ),
                      onTap: () {
                        if (isFolder) {
                          _navigateToFolder(file['name']);
                        } else {
                          // Open file mock
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Opening ${file['name']}...'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ).animate().fadeIn(delay: (index * 50).ms).slideX();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.upload_file_rounded),
      ),
    );
  }
}
