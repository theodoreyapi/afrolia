import 'package:afrolia/features/product/pages/detail_product_page.dart';
import 'package:flutter/material.dart';

// ─── Data Models ────────────────────────────────────────────────────────────

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final bool isNew;
  final double rating;
  final int soldCount;
  final String category;

  const Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isNew = false,
    this.rating = 0,
    this.soldCount = 0,
    required this.category,
  });
}

class Category {
  final String name;
  final IconData icon;
  final Color color;

  const Category({required this.name, required this.icon, required this.color});
}

// ─── Sample Data ─────────────────────────────────────────────────────────────

final List<Product> newProducts = [
  Product(
    name: 'Bonnet Satin Nuit',
    price: 2500,
    imageUrl: 'bonnet',
    isNew: true,
    rating: 4.8,
    soldCount: 789,
    category: 'Accessoires',
  ),
  Product(
    name: 'Crème Définition Boucles',
    price: 6500,
    imageUrl: 'creme',
    isNew: true,
    rating: 4.6,
    soldCount: 342,
    category: 'Soins',
  ),
  Product(
    name: 'Leave-In Bio',
    price: 6500,
    imageUrl: 'leavein',
    isNew: true,
    rating: 4.7,
    soldCount: 215,
    category: 'Bio',
  ),
];

final List<Product> bestSellers = [
  Product(
    name: 'Élastiques Sans Casse',
    price: 2000,
    imageUrl: 'elastiques',
    rating: 4.5,
    soldCount: 892,
    category: 'Accessoires',
  ),
  Product(
    name: 'Bonnet Satin Nuit',
    price: 2500,
    imageUrl: 'bonnet',
    isNew: true,
    rating: 4.8,
    soldCount: 789,
    category: 'Accessoires',
  ),
  Product(
    name: 'Beurre Karité',
    price: 6000,
    imageUrl: 'beurre',
    rating: 4.9,
    soldCount: 654,
    category: 'Bio',
  ),
];

final List<Product> allProducts = [
  Product(
    name: 'Élastiques Sans Casse',
    price: 2000,
    imageUrl: 'elastiques',
    rating: 4.5,
    soldCount: 892,
    category: 'Accessoires',
  ),
  Product(
    name: 'Bonnet Satin Nuit',
    price: 2500,
    imageUrl: 'bonnet',
    isNew: true,
    rating: 4.8,
    soldCount: 789,
    category: 'Accessoires',
  ),
  Product(
    name: 'Crème Définition Boucles',
    price: 6500,
    imageUrl: 'creme',
    isNew: true,
    rating: 4.6,
    soldCount: 342,
    category: 'Soins',
  ),
  Product(
    name: 'Beurre Karité',
    price: 6000,
    imageUrl: 'beurre',
    rating: 4.9,
    soldCount: 654,
    category: 'Bio',
  ),
  Product(
    name: 'Leave-In Bio',
    price: 6500,
    imageUrl: 'leavein',
    isNew: true,
    rating: 4.7,
    soldCount: 215,
    category: 'Bio',
  ),
  Product(
    name: 'Huile Argan Pure',
    price: 8500,
    imageUrl: 'huile',
    rating: 4.8,
    soldCount: 521,
    category: 'Soins',
  ),
];

final List<Category> categories = [
  Category(
    name: 'Soins',
    icon: Icons.spa_outlined,
    color: const Color(0xFFFFB3C6),
  ),
  Category(
    name: 'Coiffage',
    icon: Icons.content_cut_outlined,
    color: const Color(0xFFFFC8DD),
  ),
  Category(
    name: 'Accessoires',
    icon: Icons.diamond_outlined,
    color: const Color(0xFFCDB4DB),
  ),
  Category(
    name: 'Bio',
    icon: Icons.eco_outlined,
    color: const Color(0xFFB5EAD7),
  ),
];

// ─── Color Palette ───────────────────────────────────────────────────────────

const kPink = Color(0xFFE91E8C);
const kPinkMid = Color(0xFFF8BBD9);
const kPinkDark = Color(0xFFC2185B);
const kText = Color(0xFF2D1B2E);
const kTextLight = Color(0xFF8E6B8E);
const kGold = Color(0xFFFFB300);
const kGreen = Color(0xFF4CAF50);
const kWhite = Colors.white;

// ─── Product Page ─────────────────────────────────────────────────────────────

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _selectedCategory = 'Tous';
  final String _sortBy = 'Plus populaires';
  final TextEditingController _searchController = TextEditingController();

  List<Product> get filteredProducts {
    if (_selectedCategory == 'Tous') return allProducts;
    return allProducts.where((p) => p.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPink.withValues(alpha: .02),
      body: CustomScrollView(
        slivers: [
          // Search Bar
          SliverToBoxAdapter(child: _buildSearchBar()),
          // Filter Tabs
          SliverToBoxAdapter(child: _buildFilterTabs()),
          // Nouveautés Section
          SliverToBoxAdapter(
            child: _buildSectionHeader('✨ Nouveautés', onTap: () {}),
          ),
          SliverToBoxAdapter(child: _buildNewProductsCarousel()),
          // Meilleures ventes Section
          SliverToBoxAdapter(
            child: _buildSectionHeader('🔥 Meilleures ventes', onTap: () {}),
          ),
          SliverToBoxAdapter(child: _buildBestSellersCarousel()),
          // Categories
          SliverToBoxAdapter(
            child: _buildSectionHeader('Nos catégories', showViewAll: false),
          ),
          SliverToBoxAdapter(child: _buildCategoriesGrid()),
          // Divider
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  'Tous les produits',
                  style: TextStyle(
                    color: kTextLight,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          // Products count + sort
          SliverToBoxAdapter(child: _buildProductsHeader()),
          // Products Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    _buildProductGridCard(filteredProducts[index]),
                childCount: filteredProducts.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: kPink.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Rechercher un produit...',
            hintStyle: TextStyle(color: kTextLight, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: kTextLight, size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = ['Tous', 'Soins', 'Coiffage', 'Accessoires'];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = _selectedCategory == tab;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = tab),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                color: isSelected ? kPink : kWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: kPink.withValues(alpha: 0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                        ),
                      ],
              ),
              child: Text(
                tab,
                style: TextStyle(
                  color: isSelected ? kWhite : kTextLight,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    String title, {
    VoidCallback? onTap,
    bool showViewAll = true,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: kText,
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          if (showViewAll)
            GestureDetector(
              onTap: onTap,
              child: Text(
                'Voir tout',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: kPink,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNewProductsCarousel() {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: newProducts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) =>
            _buildNewProductCard(newProducts[index]),
      ),
    );
  }

  Widget _buildNewProductCard(Product product) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailProductPage(product: product)),
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: kPink.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: _buildProductImage(
                    product.imageUrl,
                    height: 140,
                    width: double.infinity,
                  ),
                ),
                if (product.isNew)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [kPink, kPinkDark]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Nouveau',
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: kText,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${product.price.toInt()} CFA',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: kPink,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBestSellersCarousel() {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: bestSellers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) =>
            _buildBestSellerCard(bestSellers[index], rank: index + 1),
      ),
    );
  }

  Widget _buildBestSellerCard(Product product, {required int rank}) {
    return Container(
      width: 155,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kPink.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: _buildProductImage(
                  product.imageUrl,
                  height: 120,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: rank == 1
                          ? [kPink, kPinkDark]
                          : rank == 2
                          ? [const Color(0xFF9C27B0), const Color(0xFF6A1B9A)]
                          : [const Color(0xFF2196F3), const Color(0xFF1565C0)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$rank',
                      style: const TextStyle(
                        color: kWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: kGold, size: 14),
                    const SizedBox(width: 3),
                    Text(
                      '${product.rating}',
                      style: TextStyle(
                        fontSize: 12,
                        color: kTextLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${product.price.toInt()} CFA',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: kPink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categories
            .map(
              (cat) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildCategoryChip(cat),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCategoryChip(Category cat) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = cat.name),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: cat.color.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cat.color.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(cat.icon, color: kPink, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              cat.name,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: kText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
      child: Row(
        children: [
          Text(
            '${filteredProducts.length} produits',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: kText,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPinkMid),
              ),
              child: Row(
                children: [
                  Icon(Icons.sort_rounded, color: kPink, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    _sortBy,
                    style: TextStyle(
                      fontSize: 12,
                      color: kPink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, color: kPink, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGridCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: kPink.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: _buildProductImage(
                  product.imageUrl,
                  height: 150,
                  width: double.infinity,
                ),
              ),
              if (product.isNew)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [kPink, kPinkDark]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Nouveau',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: kText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: kGold, size: 13),
                    const SizedBox(width: 3),
                    Text(
                      '${product.rating}',
                      style: TextStyle(fontSize: 11, color: kTextLight),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '• ${product.soldCount} vendus',
                      style: TextStyle(fontSize: 11, color: kTextLight),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${product.price.toInt()} CFA',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: kPink,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [kPink, kPinkDark]),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: kPink.withValues(alpha: 0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.add, color: kWhite, size: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(
    String imageKey, {
    required double height,
    double? width,
  }) {
    final Map<String, Color> imageColors = {
      'bonnet': const Color(0xFFF4A7C0),
      'creme': const Color(0xFFD4EDDA),
      'leavein': const Color(0xFFFFF3CD),
      'elastiques': const Color(0xFF2D1B1B),
      'beurre': const Color(0xFFFFF8E1),
      'huile': const Color(0xFFE8F5E9),
    };

    final Map<String, IconData> imageIcons = {
      'bonnet': Icons.nightlight_round,
      'creme': Icons.water_drop_outlined,
      'leavein': Icons.eco_outlined,
      'elastiques': Icons.blur_circular,
      'beurre': Icons.opacity,
      'huile': Icons.grass_outlined,
    };

    final color = imageColors[imageKey] ?? kPinkMid;
    final icon = imageIcons[imageKey] ?? Icons.image_outlined;

    return Container(
      height: height,
      width: width,
      color: color.withValues(alpha: 0.4),
      child: Center(
        child: Icon(icon, size: 52, color: color.withValues(alpha: 0.9)),
      ),
    );
  }
}
