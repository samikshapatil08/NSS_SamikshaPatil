import 'package:flutter/material.dart';

class EventListView extends StatelessWidget {
  final List<dynamic> events;
  final Function(Map<String, dynamic>) onEventTap;

  const EventListView({
    super.key,
    required this.events,
    required this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NSS Events'),
        backgroundColor: const Color.fromARGB(255, 84, 158, 219),
      ),
      body: events.isEmpty
          ? const Center(child: Text('No upcoming events found.'))
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final eventName = event['title'] ?? 'No Title';
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 17, 75, 121),
                      child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(eventName, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Tap to see details'),
                    onTap: () => onEventTap(event),
                  ),
                );
              },
            ),
    );
  }
}