enum OrderStatus { outForDelivery, delivered, cancelled }

class OrderModel {
  final String orderId;
  final String title;
  final String date;
  final String price;
  final OrderStatus status;
  final double? progressPercentage;

  const OrderModel({
    required this.orderId,
    required this.title,
    required this.date,
    required this.price,
    required this.status,
    this.progressPercentage,
  });

  String get statusLabel {
    switch (status) {
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
