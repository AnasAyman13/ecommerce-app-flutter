import 'package:equatable/equatable.dart';

class TrendingSearchModel extends Equatable {
  final String number;
  final String title;
  final bool isHot;

  const TrendingSearchModel({
    required this.number,
    required this.title,
    required this.isHot,
  });

  @override
  List<Object> get props => [number, title, isHot];
}
