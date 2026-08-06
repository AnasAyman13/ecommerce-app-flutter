import 'package:equatable/equatable.dart';

class CategoryItemModel extends Equatable {
  final String title;
  final String itemsCount;
  final String imageUrl;

  const CategoryItemModel({
    required this.title,
    required this.itemsCount,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [title, itemsCount, imageUrl];
}
