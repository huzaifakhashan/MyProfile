import 'package:flutter/material.dart';

const fullName = 'Huzaifa Abdulrahman Khashan';
const jobTitle = 'Flutter Developer';
const phone = '+963 981787496';
const email = 'Huzaifa.Khashan@gmail.com';
const githubUrl = 'https://github.com/huzaifakhashan';
const linkedinUrl = 'https://linkedin.com/in/huzaifa-khashan';

const summary =
    'I am a junior developer working with Flutter and Laravel, with a basic '
    'understanding of mobile application and web development. I have '
    'experience building simple projects and interactive applications, along '
    'with knowledge of state management in Flutter and working with databases '
    'using Eloquent ORM in Laravel.';

const summary2 =
    'I am continuously working on improving my skills through hands-on '
    'learning and building projects. I am passionate about application '
    'development and enhancing user experience, with a focus on writing clean '
    'and maintainable code.';

class Education {
  const Education(this.title, this.place, this.years);
  final String title;
  final String place;
  final String years;
}

const education = [
  Education('Software Engineering', 'Engineering and Technology (Sham University)', '2021 – 2025'),
  Education('Laravel Developer', 'Midad Educational Institution', '2023 – 2024'),
  Education('Flutter Developer', 'Midad Educational Institution', '2023 – 2024'),
];

const courses = [
  'Flutter Developer (Midad Organization)',
  'Full Stack Web (Midad Organization)',
  'PHP & Laravel 9 (Midad Organization)',
  'Database MySQL (Midad Organization)',
];

const skillGroups = <String, List<String>>{
  'Programming Languages': ['C++', 'C#', 'Java', 'Python', 'PHP', 'Dart'],
  'Web & App Development': [
    'HTML',
    'CSS',
    'Bootstrap',
    'JavaScript',
    'PHP-Laravel',
    'Dart-Flutter',
    'MVC',
    'Firebase',
  ],
  'Databases': ['SQL Server', 'MySQL', 'Oracle'],
  'Tools': [
    'Visual Studio',
    'VS Code',
    'IntelliJ IDEA',
    'NetBeans',
    'Microsoft Office',
    'Postman',
  ],
  'Version Control': ['Git (GitHub, GitLab)', 'Problem Solving'],
};

class Project {
  const Project(this.title, this.description, this.icon, this.tags, this.repo);
  final String title;
  final String description;
  final IconData icon;
  final List<String> tags;
  final String repo;

  String get url => '$githubUrl/$repo';
}

const projects = [
  Project(
    'Groupify',
    'A real-time chat and instant messaging app. Users register, exchange messages instantly, share images and files, and get push notifications.',
    Icons.forum_outlined,
    ['Flutter', 'Firebase Auth', 'Firestore', 'FCM', 'Storage'],
    'GroupifyApp',
  ),
  Project(
    'Prayer Times',
    'Accurate Islamic prayer times based on GPS, with a live countdown, Hijri calendar, multiple calculation methods and a custom Adhan sound for each prayer, even when the app is closed.',
    Icons.mosque_outlined,
    ['Flutter', 'GPS', 'Background Service', 'Notifications', 'Arabic UI'],
    'prayer_times_app',
  ),
  Project(
    'Nova Store',
    'A polished offline app-marketplace UI: search, categories, app details, animated install progress, wishlist, light/dark themes, and English/Arabic with RTL support.',
    Icons.storefront_outlined,
    ['Flutter', 'Provider', 'Localization', 'Dark mode'],
    'AppStore',
  ),
  Project(
    'Tailor Mate',
    'An app for tailors to record customer measurements, search them quickly, restore deleted records from trash, and export or import data as Excel files. Works offline.',
    Icons.straighten_outlined,
    ['Flutter', 'SQLite', 'Excel', 'Arabic UI'],
    'tailor-mate',
  ),
  Project(
    'Todo List',
    'A clean task manager with descriptions, editing, status filters, swipe-to-delete with undo, and a trash bin to restore tasks. Stored locally, so it works offline.',
    Icons.checklist_rounded,
    ['Flutter', 'Provider', 'Local storage', 'Dark mode'],
    'TodoList-app',
  ),
  Project(
    'Currency Converter',
    'A simple app for converting currencies using up-to-date exchange rates.',
    Icons.currency_exchange,
    ['Flutter', 'REST API', 'Dio'],
    'currency-converter',
  ),
];

const languages = [
  ('Arabic', 'Native proficiency', 1.0),
  ('English', 'A2–B1 (Intermediate)', 0.5),
];
