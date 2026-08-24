import 'package:flutter/material.dart';

class SettingsProfileCard extends StatelessWidget {
  final String name;
  final String email;

  const SettingsProfileCard({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B292D), Color(0xFF9B3F46)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Profile avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF4B51B),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // User information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '$email • NORR member',
                  style: TextStyle(color: Color(0xFFE4D1D0), fontSize: 9),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFD9B9BA),
            size: 20,
          ),
        ],
      ),
    );
  }
}
