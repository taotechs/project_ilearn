// ignore_for_file: library_private_types_in_public_api, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  static const routeName = '/preferences';

  const PreferencesScreen({super.key});

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final List<String> _interests = [
    'Flutter',
    'Machine Learning',
    'AI',
    'Web Development'
  ];
  List<String> _selectedInterests = [];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedInterests = prefs.getStringList('selectedInterests') ?? [];
    });
  }

  void _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectedInterests', _selectedInterests);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences saved!')),
    );
  }

  void _onInterestChanged(bool? selected, String interest) {
    setState(() {
      if (selected == true) {
        _selectedInterests.add(interest);
      } else {
        _selectedInterests.remove(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePreferences,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Select your interests:',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          ..._interests.map((interest) {
            return CheckboxListTile(
              title: Text(interest),
              value: _selectedInterests.contains(interest),
              onChanged: (selected) {
                _onInterestChanged(selected, interest);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
