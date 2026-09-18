import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'data.dart';

const maxContentWidth = 1100.0;

Future<void> openLink(String url) async {
  await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
}

/// Centers content, limits its width and adds a section title.
class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final narrow = MediaQuery.sizeOf(context).width < 700;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: narrow ? 20 : 32,
            vertical: narrow ? 40 : 64,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Container(
                width: 56,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 12),
                Text(subtitle!, style: theme.textTheme.bodyLarge),
              ],
              const SizedBox(height: 32),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// Lays children out in equal-width columns depending on available width.
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 300,
    this.spacing = 20,
  });

  final List<Widget> children;
  final double minItemWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final cols = ((constraints.maxWidth + spacing) / (minItemWidth + spacing))
          .floor()
          .clamp(1, children.length);
      final width = (constraints.maxWidth - spacing * (cols - 1)) / cols;
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          for (final c in children) SizedBox(width: width, child: c),
        ],
      );
    });
  }
}

class InfoCard extends StatefulWidget {
  const InfoCard({super.key, required this.child});
  final Widget child;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hover ? -4 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hover ? scheme.primary : scheme.outlineVariant,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w500),
      ),
    );
  }
}

// ---------------------------------------------------------------- Sections

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onContact, required this.onProjects});
  final VoidCallback onContact;
  final VoidCallback onProjects;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final narrow = MediaQuery.sizeOf(context).width < 700;

    final avatar = Container(
      width: narrow ? 140 : 200,
      height: narrow ? 140 : 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [scheme.primary, scheme.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 40,
          ),
        ],
      ),
      child: Text(
        'HK',
        style: TextStyle(
          fontSize: narrow ? 52 : 72,
          fontWeight: FontWeight.w800,
          color: scheme.onPrimary,
        ),
      ),
    );

    final text = Column(
      crossAxisAlignment:
          narrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text('Hello, I\'m',
            style: theme.textTheme.titleLarge?.copyWith(color: scheme.primary)),
        const SizedBox(height: 8),
        Text(
          fullName,
          textAlign: narrow ? TextAlign.center : TextAlign.start,
          style: (narrow
                  ? theme.textTheme.headlineMedium
                  : theme.textTheme.displaySmall)
              ?.copyWith(fontWeight: FontWeight.w800, height: 1.15),
        ),
        const SizedBox(height: 12),
        Text(jobTitle,
            style: theme.textTheme.headlineSmall
                ?.copyWith(color: scheme.onSurfaceVariant)),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: narrow ? WrapAlignment.center : WrapAlignment.start,
          children: [
            FilledButton.icon(
              onPressed: onContact,
              icon: const Icon(Icons.mail_outline),
              label: const Text('Contact me'),
            ),
            OutlinedButton.icon(
              onPressed: onProjects,
              icon: const Icon(Icons.code),
              label: const Text('View projects'),
            ),
          ],
        ),
      ],
    );

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: narrow ? 20 : 32,
            vertical: narrow ? 48 : 96,
          ),
          child: narrow
              ? Column(children: [avatar, const SizedBox(height: 32), text])
              : Row(
                  children: [
                    Expanded(child: text),
                    const SizedBox(width: 48),
                    avatar,
                  ],
                ),
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7);
    return Section(
      title: 'About Me',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(summary, style: style),
          const SizedBox(height: 16),
          Text(summary2, style: style),
        ],
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Section(
      title: 'Skills',
      child: ResponsiveGrid(
        minItemWidth: 320,
        children: [
          for (final e in skillGroups.entries)
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.key,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [for (final s in e.value) TagChip(s)],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Section(
      title: 'Education & Courses',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final e in education)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InfoCard(
                child: Row(
                  children: [
                    Icon(Icons.school_outlined, color: scheme.primary, size: 32),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.title,
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(e.place,
                              style: TextStyle(color: scheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(e.years,
                        style: TextStyle(
                            color: scheme.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 12),
          Text('Courses',
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [for (final c in courses) TagChip(c)],
          ),
        ],
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Section(
      title: 'Projects',
      child: ResponsiveGrid(
        minItemWidth: 320,
        children: [
          for (final p in projects)
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(p.icon, size: 40, color: scheme.primary),
                  const SizedBox(height: 16),
                  Text(p.title,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(p.description,
                      style: TextStyle(
                          color: scheme.onSurfaceVariant, height: 1.5)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [for (final t in p.tags) TagChip(t)],
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () => openLink(p.url),
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('View on GitHub'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class LanguagesSection extends StatelessWidget {
  const LanguagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Section(
      title: 'Languages',
      child: ResponsiveGrid(
        minItemWidth: 400,
        children: [
          for (final (name, level, value) in languages)
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(level, style: TextStyle(color: scheme.onSurfaceVariant)),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(value: value, minHeight: 8),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <(IconData, String, String)>[
      (Icons.phone_outlined, phone, 'tel:${phone.replaceAll(' ', '')}'),
      (Icons.mail_outline, email, 'mailto:$email'),
      (Icons.code, 'GitHub', githubUrl),
      (Icons.business_center_outlined, 'LinkedIn', linkedinUrl),
    ];
    return Section(
      title: 'Get In Touch',
      subtitle: 'Interested in working together? Feel free to reach out.',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final (icon, label, url) in items)
            OutlinedButton.icon(
              onPressed: () => openLink(url),
              icon: Icon(icon),
              label: Text(label),
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
            ),
        ],
      ),
    );
  }
}
