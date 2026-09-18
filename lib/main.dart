import 'package:flutter/material.dart';

import 'data.dart';
import 'widgets.dart';

void main() {
  runApp(const ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4F7CFF),
      brightness: Brightness.dark,
    );
    return MaterialApp(
      title: '$fullName | $jobTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: scheme,
        scaffoldBackgroundColor: const Color(0xFF0B1020),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _keys = {
    'About': GlobalKey(),
    'Skills': GlobalKey(),
    'Education': GlobalKey(),
    'Projects': GlobalKey(),
    'Contact': GlobalKey(),
  };

  void _goTo(String name) {
    final ctx = _keys[name]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.sizeOf(context).width < 800;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1020),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 24,
        title: Text('Huzaifa Khashan',
            style: TextStyle(
                fontWeight: FontWeight.w800, color: scheme.primary)),
        actions: narrow
            ? null
            : [
                for (final name in _keys.keys)
                  TextButton(
                      onPressed: () => _goTo(name), child: Text(name)),
                const SizedBox(width: 16),
              ],
      ),
      drawer: narrow
          ? Drawer(
              child: ListView(
                children: [
                  for (final name in _keys.keys)
                    ListTile(
                      title: Text(name),
                      onTap: () {
                        Navigator.pop(context);
                        _goTo(name);
                      },
                    ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSection(
              onContact: () => _goTo('Contact'),
              onProjects: () => _goTo('Projects'),
            ),
            KeyedSubtree(key: _keys['About'], child: const AboutSection()),
            KeyedSubtree(key: _keys['Skills'], child: const SkillsSection()),
            KeyedSubtree(
                key: _keys['Education'], child: const EducationSection()),
            KeyedSubtree(key: _keys['Projects'], child: const ProjectsSection()),
            const LanguagesSection(),
            KeyedSubtree(key: _keys['Contact'], child: const ContactSection()),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                '© ${DateTime.now().year} $fullName',
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
