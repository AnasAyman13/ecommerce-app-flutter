import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';

class RoomsSectionWidget  extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return _RoomsSectionWidget();
  }
}
class _RoomsSectionWidget extends State<RoomsSectionWidget>{
  int _selectedRoomIndex = 0;

  final List<Map<String, String>> _rooms = const [
    {
      'name': 'Sofas',
      'image':
      'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=300&auto=format&fit=crop',
    },
    {
      'name': 'Chairs',
      'image':
      'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=300&auto=format&fit=crop',
    },
    {
      'name': 'Tables',
      'image':
      'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=300&auto=format&fit=crop',
    },
    {
      'name': 'Lamps',
      'image':
      'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=300&auto=format&fit=crop',
    },
    {
      'name': 'Beds',
      'image':
      'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=300&auto=format&fit=crop',
    },
  ];
  @override
  Widget build(BuildContext context) {
   return SizedBox(
     height: 120.h,
     child: ListView.builder(
       scrollDirection: Axis.horizontal,
       padding: EdgeInsets.symmetric(horizontal: 20.w),
       itemCount: _rooms.length,
       itemBuilder: (context, index) {
         final room = _rooms[index];
         final isSelected = index == _selectedRoomIndex;

         return GestureDetector(
           onTap: () {

             setState(() => _selectedRoomIndex = index);
             Navigator.pushNamed(
               context,
               AppRouteNames.listing,
               arguments: {'categoryId': room['name']},
             );
           },
           child: Padding(
             padding: EdgeInsets.only(right: 18.w),
             child: Column(
               children: [
                 Container(
                   padding: EdgeInsets.all(2.r),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     border: Border.all(
                       color: isSelected
                           ? AppColors.primaryMaroon
                           : Colors.transparent,
                       width: 2.r,
                     ),
                   ),
                   child: ClipOval(
                     child: Image.network(
                       room['image']!,
                       width: 60.r,
                       height: 60.r,
                       fit: BoxFit.cover,
                       errorBuilder: (context, error, stackTrace) =>
                           Image.asset(
                             'assets/images/stav_oak_chair.png',
                             width: 60.r,
                             height: 60.r,
                             fit: BoxFit.cover,
                           ),
                     ),
                   ),
                 ),
                 SizedBox(height: 6.h),
                 Text(
                   room['name']!,
                   style: TextStyle(
                     fontSize: 12.sp,
                     fontWeight: isSelected
                         ? FontWeight.bold
                         : FontWeight.w500,
                     color: isSelected
                         ? AppColors.primaryMaroon
                         : AppColors.textGrey,
                   ),
                 ),
               ],
             ),
           ),
         );
       },
     ),
   );
  }

}