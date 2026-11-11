import 'package:flutter/material.dart';

class TraktoPage extends StatelessWidget {
  const TraktoPage(
    this.title,
    this.subtitle, {
    super.key,
    required this.children,
    this.spacing = 12,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      top: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              for (final child in children) ...[
                SizedBox(height: spacing),
                child,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
