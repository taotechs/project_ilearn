import 'package:flutter/material.dart';
import 'package:ilearn/main.dart';
import 'package:ilearn/widgets/gradient_card.dart';
import '../data/tech_fields.dart';
import 'detail_screen.dart';
import 'preferences_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  final Map<String, dynamic> preferences;

  const HomeScreen({super.key, required this.preferences});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> filteredFields = [];
  String query = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a delay for loading data
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        filteredFields = techFields;
        isLoading = false;
      });
    });
  }

  List<Map<String, dynamic>> getRecommendations() {
    if (widget.preferences.isEmpty) {
      return [];
    }
    final interests = widget.preferences['interests'] as List<String>;
    return techFields.where((field) {
      return interests.any((interest) =>
          field['name'].toLowerCase().contains(interest.toLowerCase()));
    }).toList();
  }

  void onSearchChanged(String text) {
    setState(() {
      query = text;
      filteredFields = techFields.where((field) {
        return field['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _navigateToAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('About'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tech Learning Roadmaps',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'This app is a comprehensive guide for students and tech enthusiasts looking to streamline their learning journey in various technology fields. The app provides personalized learning roadmaps, curated resources, and expert recommendations tailored to your interests. Whether you\'re a beginner or an experienced learner, Tech Learning Roadmaps helps you find the right path to mastering new skills.',
                ),
                SizedBox(height: 10),
                Text(
                  'Project Information',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'This app is developed as a group project for the CSC 432 Principles of Programming Language 2 course at Lagos State University. The project is undertaken by Group Two, comprising a team of dedicated students who collaborated to design, develop, and deploy this mobile application. The aim is to create a valuable resource for tech learners and to demonstrate our understanding and application of programming principles.',
                ),
                SizedBox(height: 10),
                Text(
                  'Acknowledgements',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'We would like to thank our lecturers, Pof Uwadia and Dr Oloyede, for their guidance and support throughout this project. Additionally, we express our gratitude to all our group members for their hard work and dedication in making this project a success.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToDevelopers(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Developers'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(title: Text('Taofeek Akintunde')),
                ListTile(title: Text('Ademola Abdulmalik')),
                ListTile(title: Text('Garuba Precious')),
                ListTile(title: Text('Saliu Oluwasegun')),
                ListTile(title: Text('Jamespeter Okoro')),
                ListTile(title: Text('Tinubu Precious')),
                ListTile(title: Text('Amodu Ayodele')),
                ListTile(title: Text('Adeyomoye Ayomide')),
                ListTile(title: Text('Badmus Omodebola')),
                ListTile(title: Text('Not Contrinution')),
                ListTile(title: Text('Not Contribution')),
                // Add more developers as needed
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final recommendations = getRecommendations();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Learning Roadmaps'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search tech fields...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(PreferencesScreen.routeName);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.of(context).pop();
                _navigateToAbout(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Developers'),
              onTap: () {
                Navigator.of(context).pop();
                _navigateToDevelopers(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(PreferencesScreen.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text('Back to Onboarding'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushReplacementNamed(OnboardingScreen.routeName);
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recommendations.isNotEmpty) ...[
                    Text(
                      'Recommended for you',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                        itemCount: recommendations.length,
                        itemBuilder: (context, index) {
                          final field = recommendations[index];
                          return GradientCard(
                            field: field,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                DetailScreen.routeName,
                                arguments: field,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const Divider(),
                  ] else ...[
                    Text(
                      'No recommendations available.',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                  ],
                  Text(
                    'All Tech Fields',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Expanded(
                    child: filteredFields.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                            ),
                            itemCount: filteredFields.length,
                            itemBuilder: (context, index) {
                              final field = filteredFields[index];
                              return GradientCard(
                                field: field,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    DetailScreen.routeName,
                                    arguments: field,
                                  );
                                },
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'No tech fields available.',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
