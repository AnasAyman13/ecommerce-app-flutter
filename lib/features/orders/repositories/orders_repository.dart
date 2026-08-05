import '../models/order_model.dart';

abstract interface class OrdersRepository {
  Future<List<OrderModel>> getOrders();

  Future<OrderModel> getOrder(String orderId);
}
