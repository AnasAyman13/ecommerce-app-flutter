import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                SizedBox(width: 6),
                Text(
                  "Back to sign in",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            "Create your",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xff4A2C2A),
              height: 1.1,
            ),
          ),

          const Text(
            "account",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xffA04F4F),
              height: 1.1,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            "Join 48,000+ design enthusiasts in the NORR community.",
            style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
          ),

          const SizedBox(height: 28),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xff8B4A4A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xffD9C8C1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xffEEE4DF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
