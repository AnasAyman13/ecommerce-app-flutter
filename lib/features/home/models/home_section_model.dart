import 'package:equatable/equatable.dart';

class HomeSectionModel extends Equatable {
  final String id;
  final String title;
  final List<String> productIds;

  const HomeSectionModel({
    required this.id,
    required this.title,
    this.productIds = const [],
  });

  @override
  List<Object> get props => [id, title, productIds];
}
