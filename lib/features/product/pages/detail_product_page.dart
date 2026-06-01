import 'package:afrolia/features/product/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ─── Colors ──────────────────────────────────────────────────────────────────
const kPink = Color(0xFFE91E8C);
const kPinkLight = Color(0xFFFCE4F0);
const kPinkDark = Color(0xFFC2185B);
const kGreen = Color(0xFF4CAF50);
const kGold = Color(0xFFFFB300);
const kText = Color(0xFF1A1A2E);
const kTextLight = Color(0xFF8E8E9E);
const kBg = Color(0xFFFAFAFA);
const kWhite = Colors.white;

// ─── Models ───────────────────────────────────────────────────────────────────
class Review {
  final String name;
  final double rating;
  final String date;
  final String comment;
  final Color avatarColor;

  const Review({
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
    required this.avatarColor,
  });
}

class SimilarProduct {
  final String name;
  final double price;
  final double rating;
  final Color imageColor;
  final IconData imageIcon;

  const SimilarProduct({
    required this.name,
    required this.price,
    required this.rating,
    required this.imageColor,
    required this.imageIcon,
  });
}

// ─── Sample Data ──────────────────────────────────────────────────────────────
const reviews = [
  Review(
    name: 'Safiatou B.',
    rating: 5,
    date: '16 Jan 2024',
    comment:
        'Bonnet de très bonne qualité, tient bien toute la nuit. Mes cheveux sont moins cassants au réveil.',
    avatarColor: Color(0xFF9C27B0),
  ),
  Review(
    name: 'Ramatou G.',
    rating: 5,
    date: '13 Jan 2024',
    comment:
        'Parfait ! Satin doux et élastique confortable. Protège vraiment bien les coiffures.',
    avatarColor: Color(0xFFE91E8C),
  ),
];

const similarProducts = [
  SimilarProduct(
    name: 'Élastiques Sans Casse',
    price: 2000,
    rating: 4.5,
    imageColor: Color(0xFF3E2723),
    imageIcon: Icons.blur_circular,
  ),
  SimilarProduct(
    name: 'Brosse Démêlante Flexible',
    price: 3000,
    rating: 4.7,
    imageColor: Color(0xFFF8BBD9),
    imageIcon: Icons.brush_outlined,
  ),
  SimilarProduct(
    name: 'Vaporisateur Professionnel',
    price: 2500,
    rating: 4.4,
    imageColor: Color(0xFFE0E0E0),
    imageIcon: Icons.water_drop_outlined,
  ),
  SimilarProduct(
    name: 'Pince Crabe Géante',
    price: 2000,
    rating: 4.5,
    imageColor: Color(0xFF4E342E),
    imageIcon: Icons.ac_unit_outlined,
  ),
];

// ─── Page ─────────────────────────────────────────────────────────────────────
class DetailProductPage extends StatefulWidget {
  Product? product;

  DetailProductPage({super.key, this.product});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int quantity = 1;
  final int _imageIndex = 0;

  void _increment() => setState(() => quantity++);

  void _decrement() => setState(() {
    if (quantity > 1) quantity--;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildImageSection()),
                SliverToBoxAdapter(child: _buildInfoSection()),
                SliverToBoxAdapter(child: _buildSellerRow()),
                SliverToBoxAdapter(child: _buildStockRow()),
                SliverToBoxAdapter(child: _buildDivider()),
                SliverToBoxAdapter(child: _buildDescription()),
                SliverToBoxAdapter(child: _buildUsageMode()),
                SliverToBoxAdapter(child: _buildReviewsSection()),
                SliverToBoxAdapter(child: _buildSimilarProducts()),
                SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ── Image Hero ──────────────────────────────────────────────────────────────
  Widget _buildImageSection() {
    return Stack(
      children: [
        Container(
          height: 320,
          color: kWhite,
          child: Stack(
            children: [
              // Product image placeholder
              Center(
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4A7C0).withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.nightlight_round,
                    size: 130,
                    color: Color(0xFFF4A7C0),
                  ),
                ),
              ),
              // NEW badge
              Positioned(
                top: 60,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Nouveau',
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // App Bar overlay
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _iconButton(
                  Icons.arrow_back_ios_new_rounded,
                  () => Navigator.maybePop(context),
                ),
                const Expanded(
                  child: Text(
                    'Détails du produit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: kText,
                    ),
                  ),
                ),
                _iconButton(Icons.shopping_cart_outlined, () {}),
              ],
            ),
          ),
        ),
        // Dot indicator
        Positioned(
          bottom: 14,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _imageIndex ? 22 : 8,
                height: 5,
                decoration: BoxDecoration(
                  color: i == _imageIndex
                      ? kPink
                      : kPink.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: kText),
      ),
    );
  }

  // ── Product Info ────────────────────────────────────────────────────────────
  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bonnet Satin Nuit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: kText,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '2 500 CFA',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: kPink,
                  ),
                ),
              ],
            ),
          ),
          // Rating badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: kGold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: const [
                Icon(Icons.star_rounded, color: kGold, size: 17),
                SizedBox(width: 4),
                Text(
                  '4.8',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: kText,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 3),
                Text('(2)', style: TextStyle(color: kTextLight, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Seller Row ──────────────────────────────────────────────────────────────
  Widget _buildSellerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF0E0EA)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: kPinkLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.storefront_outlined,
                color: kPink,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Beauté Naturelle',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: kText,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '789 ventes',
                    style: TextStyle(fontSize: 12, color: kTextLight),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: kPink,
                side: const BorderSide(color: kPink),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.w),
                ),
                textStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text('Voir boutique'),
            ),
          ],
        ),
      ),
    );
  }

  // ── Stock ───────────────────────────────────────────────────────────────────
  Widget _buildStockRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 4),
      child: RichText(
        text: const TextSpan(
          text: 'Stock disponible : ',
          style: TextStyle(
            fontSize: 13,
            color: kTextLight,
            fontFamily: 'Poppins',
          ),
          children: [
            TextSpan(
              text: '156 unités',
              style: TextStyle(fontWeight: FontWeight.w700, color: kText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Divider(color: Color(0xFFF0E0EA), thickness: 1),
    );
  }

  // ── Description ─────────────────────────────────────────────────────────────
  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: kText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Bonnet en satin de qualité supérieure pour protéger vos coiffures pendant la nuit. Réduit la casse et les frisottis.',
            style: TextStyle(fontSize: 13.5, color: kTextLight, height: 1.55),
          ),
        ],
      ),
    );
  }

  // ── Mode d'utilisation ───────────────────────────────────────────────────────
  Widget _buildUsageMode() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mode d'utilisation",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: kText,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F4FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFF1976D2),
                  size: 18,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Porter chaque nuit pour protéger vos cheveux',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF1565C0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Reviews ──────────────────────────────────────────────────────────────────
  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Text(
                'Avis clients',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: kText,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Voir tout (2)',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kPink,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Rating overview card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: kPink.withValues(alpha: 0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Big score
                Column(
                  children: [
                    const Text(
                      '4.8',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: kText,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(Icons.star_rounded, color: kGold, size: 15),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '2 avis',
                      style: TextStyle(fontSize: 11, color: kTextLight),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                // Bars
                Expanded(
                  child: Column(
                    children: List.generate(5, (i) {
                      final star = 5 - i;
                      final count = star == 5 ? 2 : 0;
                      final frac = star == 5 ? 1.0 : 0.0;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: Row(
                          children: [
                            Text(
                              '$star',
                              style: const TextStyle(
                                fontSize: 11,
                                color: kTextLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.star_rounded, color: kGold, size: 12),
                            const SizedBox(width: 6),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: frac,
                                  minHeight: 7,
                                  backgroundColor: const Color(0xFFF0E0EA),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        kGold,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '$count',
                              style: const TextStyle(
                                fontSize: 11,
                                color: kTextLight,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Review cards
          ...reviews.map((r) => _buildReviewCard(r)),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: review.avatarColor.withValues(alpha: 0.15),
                child: Text(
                  review.name[0],
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: review.avatarColor,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: kText,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          Icons.star_rounded,
                          color: i < review.rating
                              ? kGold
                              : const Color(0xFFE0E0E0),
                          size: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                review.date,
                style: const TextStyle(fontSize: 11, color: kTextLight),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 13,
              color: kTextLight,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Color(0xFFF5EAF0), thickness: 1),
        ],
      ),
    );
  }

  // ── Similar Products ─────────────────────────────────────────────────────────
  Widget _buildSimilarProducts() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Produits similaires',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: kText,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: similarProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) =>
                _buildSimilarCard(similarProducts[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarCard(SimilarProduct p) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: kPink.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                color: p.imageColor.withValues(alpha: 0.18),
                child: Icon(
                  p.imageIcon,
                  size: 60,
                  color: p.imageColor.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: kText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: kGold, size: 13),
                    const SizedBox(width: 3),
                    Text(
                      '${p.rating}',
                      style: const TextStyle(fontSize: 11, color: kTextLight),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${p.price.toInt()} CFA',
                  style: const TextStyle(
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

  // ── Bottom Bar ───────────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            color: kPink.withValues(alpha: 0.1),
            blurRadius: 14,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Quantity row
          Row(
            children: [
              const Text(
                'Quantité',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: kText,
                ),
              ),
              const Spacer(),
              _quantityButton(Icons.remove, _decrement),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: kText,
                  ),
                ),
              ),
              _quantityButton(Icons.add, _increment),
            ],
          ),
          SizedBox(height: 14),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart_outlined, size: 18),
                  label: Text('Ajouter au panier'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kPink,
                    side: BorderSide(color: kPink, width: 1.5),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.lock_outline_rounded, size: 18),
                  label: Text('Acheter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPink,
                    foregroundColor: kWhite,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shadowColor: kPink.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: kPinkLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 16, color: kPink),
      ),
    );
  }
}
