import 'package:flutter/material.dart';

class AppBackdrop extends StatelessWidget {
  final Widget child;

  const AppBackdrop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const icons = ['🛒', '🪑', '🛍️', '🏠', '✨', '🛒', '🛋️', '💳'];
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF171311)
              : const Color(0xFFFAF6F0),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: .055,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Wrap(
                  spacing: 42,
                  runSpacing: 30,
                  children: List.generate(
                    180,
                    (index) => Text(
                      icons[index % icons.length],
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
