import 'package:flutter/material.dart';
import '../models/wishlist_item_model.dart';

class WishlistViewModel extends ChangeNotifier {
  final List<WishlistItemModel> _items = [
    const WishlistItemModel(
      id: 'w1',
      title: 'Arik Lounge Chair',
      rating: 4.6,
      price: '\$480',
      imageUrl:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
    ),
    const WishlistItemModel(
      id: 'w2',
      title: 'Vela Floor Lamp',
      rating: 4.4,
      price: '\$320',
      imageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&auto=format&fit=crop',
    ),
    const WishlistItemModel(
      id: 'w3',
      title: 'Fjord Sectional',
      rating: 4.9,
      price: '\$2,650',
      imageUrl:
          'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500&auto=format&fit=crop',
    ),
    const WishlistItemModel(
      id: 'w4',
      title: 'Holm Dining Table',
      rating: 4.7,
      price: '\$1,200',
      imageUrl:
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500&auto=format&fit=crop',
    ),
    const WishlistItemModel(
      id: 'w5',
      title: 'Bergen Sofa',
      rating: 4.8,
      price: '\$1,840',
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
    ),
    const WishlistItemModel(
      id: 'w6',
      title: 'Stav Oak Chair',
      rating: 4.5,
      price: '\$340',
      imageUrl:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
    ),
  ];

  List<WishlistItemModel> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  String get totalSavedValue {
    double total = 0;
    for (var item in _items) {
      final cleanPrice = item.price.replaceAll('\$', '').replaceAll(',', '');
      total += double.tryParse(cleanPrice) ?? 0;
    }
    return '\$${total.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void clearAll() {
    _items.clear();
    notifyListeners();
  }
}
