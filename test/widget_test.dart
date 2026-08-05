import 'package:ecommerce_app/features/orders/models/order_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('OrderModel returns correct status label', () {
    const order = OrderModel(
      orderId: '#ORD-4821',
      title: 'Bergen Sofa',
      date: 'Jun 28, 2025',
      price: '\$2,310',
      status: OrderStatus.outForDelivery,
    );

    expect(order.statusLabel, 'Out for Delivery');
  });
}
