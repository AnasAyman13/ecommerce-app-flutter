import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/locale_controller.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final SharedPreferences _prefs;
  int count = 0;
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    _prefs = sl<SharedPreferences>();
    count = _prefs.getInt('orders_count') ?? 0;
    history = (_prefs.getStringList('orders_history') ?? <String>[])
        .map((raw) => Map<String, dynamic>.from(jsonDecode(raw) as Map))
        .toList()
        .reversed
        .toList();
  }

  Future<void> _reviewOrder(int index) async {
    var rating = 5.0;
    final comment = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(tr(context, 'Rate your order', 'قيّم طلبك')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${rating.toInt()} / 5 ⭐'),
              Slider(
                value: rating,
                min: 1,
                max: 5,
                divisions: 4,
                onChanged: (v) => setDialogState(() => rating = v),
              ),
              TextField(
                controller: comment,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: tr(
                    context,
                    'Write a review (optional)',
                    'اكتب تقييمك (اختياري)',
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(tr(context, 'Cancel', 'إلغاء')),
            ),
            FilledButton(
              onPressed: () async {
                final reviewed =
                    _prefs.getStringList('reviewed_orders') ?? <String>[];
                if (!reviewed.contains('$index')) reviewed.add('$index');
                await _prefs.setStringList('reviewed_orders', reviewed);
                await _prefs.setInt('reviews_count', reviewed.length);
                if (mounted) setState(() {});
                if (dialogContext.mounted) Navigator.pop(dialogContext);
              },
              child: Text(tr(context, 'Submit review', 'إرسال التقييم')),
            ),
          ],
        ),
      ),
    );
    comment.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviewed = _prefs.getStringList('reviewed_orders') ?? <String>[];
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'My orders', 'طلباتي'))),
      body: count == 0
          ? Center(
              child: Text(
                tr(context, 'No orders yet.', 'لا توجد طلبات حتى الآن.'),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: history.isEmpty ? count : history.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = history.isEmpty
                    ? <String, dynamic>{'items': [], 'total': 0}
                    : history[index];
                final items = order['items'] as List<dynamic>? ?? const [];
                return Card(
                  child: ExpansionTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.check_circle_outline),
                    ),
                    title: Text(
                      '${tr(context, 'Order', 'طلب')} #${(history.isEmpty ? count : history.length) - index}',
                    ),
                    subtitle: Text(
                      '${tr(context, 'Delivered', 'تم التوصيل')} • EGP ${(order['total'] as num? ?? 0).toStringAsFixed(2)}',
                    ),
                    trailing: reviewed.contains('$index')
                        ? const Icon(Icons.star, color: Colors.amber)
                        : TextButton(
                            onPressed: () => _reviewOrder(index),
                            child: Text(tr(context, 'Review', 'قيّم')),
                          ),
                    children: [
                      ...items.map((raw) {
                        final item = Map<String, dynamic>.from(raw as Map);
                        return ListTile(
                          title: Text('${item['title'] ?? ''}'),
                          subtitle: Text(
                            '${tr(context, 'Quantity', 'الكمية')}: ${item['quantity'] ?? 1}',
                          ),
                          trailing: Text(
                            'EGP ${(item['price'] as num? ?? 0).toStringAsFixed(2)}',
                          ),
                        );
                      }),
                      ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: Text('${order['address'] ?? ''}'),
                        subtitle: Text(
                          '${tr(context, 'Payment', 'الدفع')}: ${order['method'] ?? ''}',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }
}
