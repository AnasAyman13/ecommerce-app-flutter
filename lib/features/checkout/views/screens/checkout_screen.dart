import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/locale_controller.dart';
import '../../../../core/di/service_locator.dart';
import '../../../cart/view_models/cart_view_model.dart';
import '../../../../core/routing/app_route_names.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String method = 'Cash on delivery';
  final address = TextEditingController();
  final card = TextEditingController();

  @override
  void dispose() {
    address.dispose();
    card.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text(tr(context, 'Checkout', 'إتمام الشراء'))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            tr(context, 'Delivery address', 'عنوان التوصيل'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: address,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: tr(
                context,
                'Enter your Egyptian address',
                'اكتب عنوانك في مصر',
              ),
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            tr(context, 'Payment method', 'طريقة الدفع'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          RadioListTile<String>(
            value: 'Cash on delivery',
            groupValue: method,
            onChanged: (v) => setState(() => method = v!),
            title: Text(tr(context, 'Cash on delivery', 'الدفع عند الاستلام')),
            subtitle: Text(
              tr(context, 'Pay when your order arrives', 'ادفع عند وصول الطلب'),
            ),
            secondary: const Icon(Icons.payments_outlined),
          ),
          RadioListTile<String>(
            value: 'Visa card',
            groupValue: method,
            onChanged: (v) => setState(() => method = v!),
            title: Text(tr(context, 'Visa card', 'بطاقة فيزا')),
            secondary: const Icon(Icons.credit_card_outlined),
          ),
          if (method == 'Visa card') ...[
            TextField(
              controller: card,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: tr(context, 'Card number', 'رقم البطاقة'),
                prefixIcon: Icon(Icons.credit_card),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tr(
                context,
                'Demo checkout: no real charge will be made.',
                'دفع تجريبي: لن يتم خصم أي مبلغ حقيقي.',
              ),
              style: TextStyle(color: Colors.grey),
            ),
          ],
          const SizedBox(height: 28),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(tr(context, 'Total', 'الإجمالي')),
                  Text(
                    'EGP ${cart.grandTotal.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () async {
              final prefs = sl<SharedPreferences>();
              final signedIn =
                  (prefs.getString('session_email') ?? '').isNotEmpty;
              if (!signedIn) {
                await showDialog<void>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: Text(
                      tr(context, 'Sign in required', 'تسجيل الدخول مطلوب'),
                    ),
                    content: Text(
                      tr(
                        context,
                        'You are a guest. Please sign in to place an order.',
                        'أنت تستخدم وضع الزائر. سجل الدخول لإتمام الطلب.',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text(tr(context, 'Cancel', 'إلغاء')),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          dialogContext,
                          AppRouteNames.login,
                          (_) => false,
                        ),
                        child: Text(tr(context, 'Sign in', 'تسجيل الدخول')),
                      ),
                    ],
                  ),
                );
                return;
              }
              if (address.text.trim().isEmpty ||
                  (method == 'Visa card' &&
                      card.text.replaceAll(' ', '').length < 12)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      tr(
                        context,
                        'Please complete the checkout details',
                        'من فضلك أكمل بيانات الطلب',
                      ),
                    ),
                  ),
                );
                return;
              }
              final orderItems = cart.cartItems
                  .map((item) => item.toJson())
                  .toList();
              final history =
                  prefs.getStringList('orders_history') ?? <String>[];
              history.add(
                jsonEncode({
                  'items': orderItems,
                  'total': cart.grandTotal,
                  'address': address.text.trim(),
                  'method': method,
                  'date': DateTime.now().toIso8601String(),
                }),
              );
              await prefs.setStringList('orders_history', history);
              await prefs.setInt(
                'orders_count',
                (prefs.getInt('orders_count') ?? 0) + 1,
              );
              await prefs.setString(
                'last_notification',
                tr(context, 'Order placed successfully', 'تم تأكيد طلبك بنجاح'),
              );
              cart.clearCart();
              showDialog<void>(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text(tr(context, 'Order placed', 'تم تأكيد الطلب')),
                  content: Text(
                    '${tr(context, 'Your order will be delivered to', 'سيتم توصيل طلبك إلى')} ${address.text.trim()}.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouteNames.orders,
                        (_) => false,
                      ),
                      child: Text(tr(context, 'Done', 'تم')),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.check_circle_outline),
            label: Text(tr(context, 'Place order', 'تأكيد الطلب')),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryMaroon,
            ),
          ),
        ],
      ),
    );
  }
}
