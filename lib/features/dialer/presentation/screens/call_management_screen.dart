import 'package:flutter/material.dart';
import 'call_history_screen.dart';
import 'contacts_screen.dart';
import 'dialer_screen.dart';

class CallManagementScreen extends StatefulWidget {
  const CallManagementScreen({super.key});

  @override
  State<CallManagementScreen> createState() => _CallManagementScreenState();
}

class _CallManagementScreenState extends State<CallManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Recents', icon: Icon(Icons.access_time_rounded)),
              Tab(text: 'Contacts', icon: Icon(Icons.people_rounded)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [CallHistoryScreen(), ContactsScreen()],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const DialerScreen()));
        },
        icon: const Icon(Icons.dialpad_rounded),
        label: const Text('Keypad'),
      ),
    );
  }
}
