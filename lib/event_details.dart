import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsView extends StatelessWidget {
  final Map<String, dynamic> event;
  final VoidCallback onBack;

  const EventDetailsView({
    super.key,
    required this.event,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final eventName = event['title'] ?? 'Event Details';
    final eventDescription = event['description'] ?? 'No Description Available';
    final location = event['location'] ?? 'Location not specified';
    final dateString = event['event_date'] ?? 'Date not available';

    String formattedDateTime = '';
    try {
      final parsedDate = DateTime.parse(dateString);
      formattedDateTime = DateFormat('MMM d, h:mm a').format(parsedDate);
    } catch (e) {
      print(e);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        title: Text(eventName, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 84, 158, 219),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventName,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Location: $location',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: $formattedDateTime',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'About the Event',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              eventDescription,
              style: const TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
