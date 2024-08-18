import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  const DetailScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)){
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> field =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(field['name']),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field['name'],
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
              const SizedBox(height: 16.0),
              Text(
                field['description'],
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Details',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              ...field['details'].map<Widget>((detail) {
                return ListTile(
                  leading: const Icon(Icons.check, color: Colors.deepPurple),
                  title: Text(detail),
                );
              }).toList(),
              const SizedBox(height: 16.0),
              Text(
                'Resources',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              ...field['resources'].map<Widget>((resource) {
                return ListTile(
                  leading: const Icon(Icons.link, color: Colors.deepPurple),
                  title: Text(resource),
                  onTap: () {
                    _launchUrl(resource);
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}