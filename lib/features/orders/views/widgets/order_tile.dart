import 'package:flutter/material.dart';
import '../../models/order_model.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;

  const OrderTile({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text('Order ${order.orderId}'),
      subtitle: Text(order.statusLabel),
      trailing: Text(order.price),
    );
  }
}
