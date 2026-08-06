import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

enum SearchSubView { categories, discover, listing }

class SearchScreen extends StatefulWidget {
  final SearchSubView initialView;
  final String? initialCategory;

  const SearchScreen({
    super.key,
    this.initialView = SearchSubView.categories,
    this.initialCategory,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchSubView _currentView;
  String _selectedCategoryTitle = 'Sofas & Chairs';
  String _selectedPill = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categoryPills = const [
    'All',
    'New',
    'Sale',
    'Bestsellers',
    'Eco-Line',
  ];

  final List<Map<String, String>> _categories = const [
    {
      'title': 'Living Room',
      'items': '142 items',
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
    },
    {
      'title': 'Bedroom',
      'items': '87 items',
      'image':
          'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=500&auto=format&fit=crop',
    },
    {
      'title': 'Chairs',
      'items': '64 items',
      'image':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
    },
    {
      'title': 'Lighting',
      'items': '55 items',
      'image':
          'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&auto=format&fit=crop',
    },
    {
      'title': 'Dining',
      'items': '38 items',
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500&auto=format&fit=crop',
    },
  ];

  final List<String> _recentSearches = const [
    'Oslo sofa',
    'Oak dining table',
    'Floor lamp',
    'Accent chair',
    'Bouclé',
  ];

  final List<Map<String, dynamic>> _trendingSearches = const [
    {'number': '01', 'title': 'Bouclé armchair', 'isHot': true},
    {'number': '02', 'title': 'Marble coffee table', 'isHot': true},
    {'number': '03', 'title': 'Rattan pendant', 'isHot': false},
    {'number': '04', 'title': 'Japandi bookcase', 'isHot': false},
    {'number': '05', 'title': 'Travertine side table', 'isHot': false},
  ];

  final List<Map<String, dynamic>> _listingProducts = const [
    {
      'id': 'p1',
      'title': 'Bergen Sofa',
      'rating': 4.8,
      'price': '\$1,840',
      'oldPrice': '\$2,200',
      'imageUrl':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500&auto=format&fit=crop',
      'isSale': true,
    },
    {
      'id': 'p2',
      'title': 'Arik Lounge Chair',
      'rating': 4.6,
      'price': '\$480',
      'imageUrl':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
      'isSale': false,
    },
    {
      'id': 'p3',
      'title': 'Fjord Sectional',
      'rating': 4.9,
      'price': '\$2,650',
      'imageUrl':
          'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=500&auto=format&fit=crop',
      'isSale': false,
    },
    {
      'id': 'p4',
      'title': 'Stav Oak Chair',
      'rating': 4.5,
      'price': '\$340',
      'imageUrl':
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=500&auto=format&fit=crop',
      'isSale': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentView = widget.initialView;
    if (widget.initialCategory != null) {
      _selectedCategoryTitle = widget.initialCategory!;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openListing(String title) {
    setState(() {
      _selectedCategoryTitle = title;
      _currentView = SearchSubView.listing;
    });
  }

  void _openDiscover() {
    setState(() {
      _currentView = SearchSubView.discover;
    });
  }

  void _openCategories() {
    setState(() {
      _currentView = SearchSubView.categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      body: SafeArea(
        child: PopScope(
          canPop: _currentView == SearchSubView.categories,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              if (_currentView == SearchSubView.listing) {
                _openDiscover();
              } else if (_currentView == SearchSubView.discover) {
                _openCategories();
              }
            }
          },
          child: IndexedStack(
            index: _currentView.index,
            children: [
              _buildCategoriesView(),
              _buildDiscoverView(),
              _buildListingView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  // ================= VIEW 1: CATEGORIES VIEW =================
  Widget _buildCategoriesView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),

          // Header Row (Shop by Category + Search Icon Button)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shop by',
                      style: AppTextStyles.serifHeader.copyWith(
                        fontSize: 26.sp,
                        color: AppColors.textDark,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      'Category',
                      style: AppTextStyles.serifHeader.copyWith(
                        fontSize: 26.sp,
                        color: AppColors.primaryMaroon,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
                // Search Button (Switches to Discover view)
                GestureDetector(
                  onTap: _openDiscover,
                  child: Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: const BoxDecoration(
                      color: AppColors.lightPillBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search_rounded,
                      color: AppColors.textDark,
                      size: 22.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Category Filter Pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: _categoryPills.map((pill) {
                final isSelected = _selectedPill == pill;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedPill = pill),
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
                        pill,
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
          SizedBox(height: 18.h),

          // Category Cards (Featured Big Card + Grid)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Big Featured Category Card (Living Room)
                GestureDetector(
                  onTap: () => _openListing('Living Room'),
                  child: Container(
                    height: 180.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: Stack(
                        children: [
                          Image.network(
                            _categories[0]['image']!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/stav_oak_chair.png',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withValues(alpha: 0.6),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16.h,
                            left: 20.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _categories[0]['title']!,
                                  style: AppTextStyles.serifHeader.copyWith(
                                    color: AppColors.white,
                                    fontSize: 22.sp,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  _categories[0]['items']!,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 16.h,
                            right: 20.w,
                            child: CircleAvatar(
                              radius: 18.r,
                              backgroundColor: Colors.white.withValues(alpha: 0.3),
                              child: Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 14.h),

                // 2x2 Grid of standard category cards
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _categories.length - 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.15,
                    crossAxisSpacing: 14.w,
                    mainAxisSpacing: 14.h,
                  ),
                  itemBuilder: (context, index) {
                    final item = _categories[index + 1];
                    return GestureDetector(
                      onTap: () => _openListing(item['title']!),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Stack(
                          children: [
                            Image.network(
                              item['image']!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                'assets/images/stav_oak_chair.png',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withValues(alpha: 0.6),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12.h,
                              left: 14.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: AppTextStyles.serifHeader.copyWith(
                                      color: AppColors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  Text(
                                    item['items']!,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 12.h,
                              right: 12.w,
                              child: CircleAvatar(
                                radius: 14.r,
                                backgroundColor:
                                    Colors.white.withValues(alpha: 0.3),
                                child: Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ================= VIEW 2: DISCOVER / SEARCH VIEW =================
  Widget _buildDiscoverView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),

          // Header Row with Back Button + Discover Title
          Row(
            children: [
              GestureDetector(
                onTap: _openCategories,
                child: Container(
                  width: 40.r,
                  height: 40.r,
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
              SizedBox(width: 14.w),
              Text(
                'Discover',
                style: AppTextStyles.serifHeader.copyWith(
                  fontSize: 28.sp,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Search Input Bar with Voice Icon & Maroon Border
          Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(26.r),
              border: Border.all(
                color: AppColors.primaryMaroon,
                width: 1.5.r,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: AppColors.primaryMaroon,
                  size: 22.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (query) {
                      if (query.isNotEmpty) _openListing(query);
                    },
                    decoration: InputDecoration(
                      hintText: 'scandinavian sofa...',
                      hintStyle: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: const BoxDecoration(
                    color: AppColors.lightPillBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mic_outlined,
                    color: AppColors.textDark,
                    size: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // Auto-complete suggestions drop-down card
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSearchSuggestionItem(
                  'scandinavian',
                  'sofa beige',
                  onTap: () => _openListing('Scandinavian Sofa'),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildSearchSuggestionItem(
                  'scandinavian',
                  'dining table',
                  onTap: () => _openListing('Dining Table'),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildSearchSuggestionItem(
                  'scandinavian',
                  'armchair oak',
                  onTap: () => _openListing('Armchair Oak'),
                ),
              ],
            ),
          ),
          SizedBox(height: 22.h),

          // RECENT SEARCHES
          Text(
            'RECENT SEARCHES',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textGrey,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _recentSearches.map((term) {
              return GestureDetector(
                onTap: () => _openListing(term),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightPillBg,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14.sp,
                        color: AppColors.textGrey,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        term,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24.h),

          // TRENDING NOW
          Text(
            'TRENDING NOW',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textGrey,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 10.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _trendingSearches.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 16, color: Colors.black12),
            itemBuilder: (context, index) {
              final item = _trendingSearches[index];
              return GestureDetector(
                onTap: () => _openListing(item['title'] as String),
                child: Row(
                  children: [
                    Text(
                      item['number'] as String,
                      style: AppTextStyles.serifHeader.copyWith(
                        fontSize: 18.sp,
                        color: Colors.black26,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Text(
                        item['title'] as String,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    if (item['isHot'] == true) ...[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBEAEB),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Text('🔥', style: TextStyle(fontSize: 10.sp)),
                            SizedBox(width: 4.w),
                            Text(
                              'Hot',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryMaroon,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18.sp,
                      color: AppColors.textGrey,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildSearchSuggestionItem(
    String prefix,
    String suffix, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Icon(
              Icons.search_rounded,
              size: 16.sp,
              color: AppColors.textGrey,
            ),
            SizedBox(width: 12.w),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 13.sp, color: AppColors.textDark),
                children: [
                  TextSpan(
                    text: prefix,
                    style: const TextStyle(
                      color: AppColors.primaryMaroon,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: suffix),
                ],
              ),
            ),
            const Spacer(),
            Icon(
              Icons.north_west_rounded,
              size: 14.sp,
              color: AppColors.textGrey,
            ),
          ],
        ),
      ),
    );
  }

  // ================= VIEW 3: PRODUCT LISTING VIEW =================
  Widget _buildListingView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),

          // Header Row (Back Arrow + Category Title + Grid Icon)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _openDiscover,
                  child: Container(
                    width: 40.r,
                    height: 40.r,
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
                Text(
                  _selectedCategoryTitle,
                  style: AppTextStyles.serifHeader.copyWith(
                    fontSize: 22.sp,
                    color: AppColors.textDark,
                  ),
                ),
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: const BoxDecoration(
                    color: AppColors.lightPillBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.grid_view_rounded,
                    color: AppColors.textDark,
                    size: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),

          // Sub-category Horizontal Pills
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: ['All', 'Sofas', 'Sectionals', 'Lounge Chairs', 'Ottomans']
                  .map((sub) {
                final isSelected = sub == 'All';
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 9.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.darkBrownPill
                          : AppColors.lightPillBg,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      sub,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.white : AppColors.textDark,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16.h),

          // Results Count & Price / Filter Buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '142 results',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textGrey,
                  ),
                ),
                Row(
                  children: [
                    // Price button
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightPillBg,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.swap_vert_rounded, size: 14.sp),
                          SizedBox(width: 4.w),
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Filter button
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryMaroon,
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.tune_rounded,
                            size: 14.sp,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Product Grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _listingProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 16.h,
              ),
              itemBuilder: (context, index) {
                final item = _listingProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRouteNames.productDetails,
                      arguments: {'productId': item['id']},
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBg,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24.r),
                                ),
                                child: Image.network(
                                  item['imageUrl'] as String,
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    'assets/images/stav_oak_chair.png',
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (item['isSale'] == true)
                                Positioned(
                                  top: 10.h,
                                  left: 10.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryMaroon,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'SALE',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: Container(
                                  padding: EdgeInsets.all(6.r),
                                  decoration: const BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.favorite_border_rounded,
                                    size: 16.sp,
                                    color: AppColors.primaryMaroon,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ...List.generate(
                                    5,
                                    (i) => Icon(
                                      Icons.star_rounded,
                                      size: 12.sp,
                                      color: AppColors.starYellow,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '${item['rating']}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: AppColors.textGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                item['title'] as String,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  Text(
                                    item['price'] as String,
                                    style: AppTextStyles.serifPrice.copyWith(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  if (item['oldPrice'] != null) ...[
                                    SizedBox(width: 6.w),
                                    Text(
                                      item['oldPrice'] as String,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: AppColors.textGrey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
