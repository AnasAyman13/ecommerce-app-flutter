import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? trailingText;
  final VoidCallback? onTap;
  final bool showDivider;

  const SettingsItem({
    super.key,
    required this.title,
    this.subtitle,
    this.trailingText,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        constraints: const BoxConstraints(minHeight: 60),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 9,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            if (trailingText != null) ...[
              Flexible(
                child: Text(
                  trailingText!,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],

            Icon(
              Icons.chevron_right_rounded,
              size: 17,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
