import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  // ── Money / Price ────────────────────────────────────

  /// Formats a number as EGP price: "EGP 1,250.00"
  static String price(num amount, {String currency = 'EGP'}) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '$currency ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Formats discount badge: "-20%"
  static String discount(int percent) => '-$percent%';

  // ── Date / Time ─────────────────────────────────────

  /// "Aug 4, 2026"
  static String shortDate(DateTime date) =>
      DateFormat('MMM d, yyyy').format(date);

  /// "Aug 4, 2026 · 11:30 PM"
  static String fullDateTime(DateTime date) =>
      DateFormat('MMM d, yyyy · hh:mm a').format(date);

  /// "2 hours ago" / "Yesterday" / "Aug 4"
  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return shortDate(date);
  }

  // ── Numbers ──────────────────────────────────────────

  /// "1,250" with commas
  static String number(num value) => NumberFormat('#,###').format(value);

  /// "1.2K", "3.4M"
  static String compact(num value) => NumberFormat.compact().format(value);
}
