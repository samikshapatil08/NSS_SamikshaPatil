import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nss_samiksha_patil/event_details.dart';
import 'package:nss_samiksha_patil/eventlist.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  // State variables are held here
  List<dynamic>? _allEvents;
  Map<String, dynamic>? _selectedEvent;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    const url = 'https://cocomm-api.onrender.com/events';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final dynamic jsonResponse = jsonDecode(response.body);
        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('events')) {
          setState(() {
            _allEvents = jsonResponse['events'];
          });
        } else {
          throw const FormatException('Unexpected JSON format.');
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to load events: ${response.statusCode}';
          _allEvents = [];
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        _allEvents = [];
      });
    }
  }

  void _selectEvent(Map<String, dynamic> event) {
    setState(() {
      _selectedEvent = event;
    });
  }

  void _unselectEvent() {
    setState(() {
      _selectedEvent = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentView;

    if (_allEvents == null) {
      currentView = const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (_errorMessage != null) {
      currentView = Scaffold(body: Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 16.0))));
    } else if (_selectedEvent != null) {
      currentView = EventDetailsView(
        event: _selectedEvent!,
        onBack: _unselectEvent,
      );
    } else {
      currentView = EventListView(
        events: _allEvents!,
        onEventTap: _selectEvent,
      );
    }

    return currentView;
  }
}
