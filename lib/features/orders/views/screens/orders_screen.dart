import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../models/order_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _selectedTab = 'All';

  final List<OrderModel> _allOrders = const [
    OrderModel(
      orderId: '#ORD-4821',
      title: 'Bergen Sofa + Stav Chair',
      date: 'Jun 28, 2025',
      price: '\$2,310',
      status: OrderStatus.outForDelivery,
      progressPercentage: 0.75,
    ),
    OrderModel(
      orderId: '#ORD-4756',
      title: 'Vela Floor Lamp',
      date: 'Jun 12, 2025',
      price: '\$320',
      status: OrderStatus.delivered,
    ),
    OrderModel(
      orderId: '#ORD-4698',
      title: 'Holm Dining Table',
      date: 'May 30, 2025',
      price: '\$1,200',
      status: OrderStatus.delivered,
    ),
    OrderModel(
      orderId: '#ORD-4614',
      title: 'Oslo Bookcase × 2',
      date: 'May 11, 2025',
      price: '\$980',
      status: OrderStatus.cancelled,
    ),
  ];

  List<OrderModel> get _filteredOrders {
    if (_selectedTab == 'Active') {
      return _allOrders.where((o) => o.status == OrderStatus.outForDelivery).toList();
    } else if (_selectedTab == 'Delivered') {
      return _allOrders.where((o) => o.status == OrderStatus.delivered).toList();
    } else if (_selectedTab == 'Cancelled') {
      return _allOrders.where((o) => o.status == OrderStatus.cancelled).toList();
    }
    return _allOrders;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Active', 'Delivered', 'Cancelled'];

    return Scaffold(
      backgroundColor: AppColors.bgCream,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8.h),
            // Header Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 42.r,
                      height: 42.r,
                      decoration: const BoxDecoration(
                        color: AppColors.lightPillBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.textDark,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'My Orders',
                          style: AppTextStyles.serifHeader.copyWith(
                            fontSize: 22.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryMaroon,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '12',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 42.r), // spacer to balance back button
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Horizontal Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: tabs.map((tab) {
                  final isSelected = _selectedTab == tab;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = tab),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.darkBrownPill
                              : AppColors.lightPillBg,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Text(
                          tab,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.textDark,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.h),

            // Orders List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                itemCount: _filteredOrders.length,
                separatorBuilder: (context, index) => SizedBox(height: 14.h),
                itemBuilder: (context, index) {
                  final order = _filteredOrders[index];
                  return _buildOrderCard(order);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildOrderCard(OrderModel order) {
    Color chipBg;
    Color chipTextColor;

    switch (order.status) {
      case OrderStatus.outForDelivery:
        chipBg = AppColors.amberBg;
        chipTextColor = AppColors.amberGold;
        break;
      case OrderStatus.delivered:
        chipBg = AppColors.mintBg;
        chipTextColor = AppColors.mintGreen;
        break;
      case OrderStatus.cancelled:
        chipBg = AppColors.cancelledBg;
        chipTextColor = AppColors.cancelledRed;
        break;
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID and Status Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderId,
                style: AppTextStyles.serifTitle.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.textDark,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  order.statusLabel,
                  style: TextStyle(
                    color: chipTextColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // Items title
          Text(
            order.title,
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.textGrey,
            ),
          ),

          // Delivery progress if active
          if (order.progressPercentage != null) ...[
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery progress',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${(order.progressPercentage! * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.amberGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: order.progressPercentage,
                minHeight: 5.h,
                backgroundColor: const Color(0xFFEBE3D9),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFC59960)),
              ),
            ),
          ],

          SizedBox(height: 16.h),

          // Date, Price & Details Button
          Row(
            children: [
              Text(
                order.date,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textGrey,
                ),
              ),
              const Spacer(),
              Text(
                order.price,
                style: AppTextStyles.serifPrice.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.lightPillBg,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  'Details',
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
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
