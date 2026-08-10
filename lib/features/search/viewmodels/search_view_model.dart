import 'package:flutter/material.dart';
import '../models/category_item_model.dart';
import '../models/trending_search_model.dart';

enum SearchSubView { categories, discover, listing }

class SearchViewModel extends ChangeNotifier {
  SearchSubView _currentView = SearchSubView.categories;
  String _selectedCategoryTitle = 'Sofas & Chairs';
  String _selectedCategoryPill = 'All';

  SearchSubView get currentView => _currentView;
  String get selectedCategoryTitle => _selectedCategoryTitle;
  String get selectedCategoryPill => _selectedCategoryPill;

  final List<String> categoryPills = const [
    'All',
    'New',
    'Sale',
    'Bestsellers',
    'Eco-Line',
  ];

  final List<CategoryItemModel> categories = const [
    CategoryItemModel(
      title: 'Living Room',
      itemsCount: '142 items',
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
    ),
    CategoryItemModel(
      title: 'Bedroom',
      itemsCount: '87 items',
      imageUrl:
          'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=500&auto=format&fit=crop',
    ),
    CategoryItemModel(
      title: 'Chairs',
      itemsCount: '64 items',
      imageUrl:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
    ),
    CategoryItemModel(
      title: 'Lighting',
      itemsCount: '55 items',
      imageUrl:
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&auto=format&fit=crop',
    ),
    CategoryItemModel(
      title: 'Dining',
      itemsCount: '38 items',
      imageUrl:
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500&auto=format&fit=crop',
    ),
  ];

  final List<String> recentSearches = const [
    'Oslo sofa',
    'Oak dining table',
    'Floor lamp',
    'Accent chair',
    'Bouclé',
  ];

  final List<TrendingSearchModel> trendingSearches = const [
    TrendingSearchModel(number: '01', title: 'Bouclé armchair', isHot: true),
    TrendingSearchModel(number: '02', title: 'Marble coffee table', isHot: true),
    TrendingSearchModel(number: '03', title: 'Rattan pendant', isHot: false),
    TrendingSearchModel(number: '04', title: 'Japandi bookcase', isHot: false),
    TrendingSearchModel(number: '05', title: 'Travertine side table', isHot: false),
  ];

  void setInitialView(SearchSubView view, String? category) {
    _currentView = view;
    if (category != null) {
      _selectedCategoryTitle = category;
    }
  }

  void openCategories() {
    _currentView = SearchSubView.categories;
    notifyListeners();
  }

  void openDiscover() {
    _currentView = SearchSubView.discover;
    notifyListeners();
  }

  void openListing(String categoryTitle) {
    _selectedCategoryTitle = categoryTitle;
    _currentView = SearchSubView.listing;
    notifyListeners();
  }

  void selectCategoryPill(String pill) {
    _selectedCategoryPill = pill;
    notifyListeners();
  }
}
