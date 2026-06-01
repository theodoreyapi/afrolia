import 'package:afrolia/features/product/pages/checkout_page.dart';
import 'package:flutter/material.dart';

// --- Palette de couleurs fournie ---
const kPink = Color(0xFFE91E8C);
const kPinkLight = Color(0xFFFCE4F0);
const kPinkDark = Color(0xFFC2185B);
const kGreen = Color(0xFF4CAF50);
const kGold = Color(0xFFFFB300);
const kText = Color(0xFF1A1A2E);
const kTextLight = Color(0xFF8E8E9E);
const kBg = Color(0xFFFAFAFA);
const kWhite = Colors.white;

class CartProductPage extends StatefulWidget {
  CartProductPage({super.key});

  @override
  State<CartProductPage> createState() => _CartProductPageState();
}

class _CartProductPageState extends State<CartProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kBg,
        elevation: 0,
        leading: BackButton(color: kText),
        title: Text(
          'Mon Panier',
          style: TextStyle(
            color: kText,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '3 articles',
                style: TextStyle(color: kTextLight, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Liste des Articles ---
            CartItemCard(
              title: 'Huile de Coco Vierge Bio',
              price: '8 500 CFA',
              quantity: 2,
              stock: 45,
              imageUrl:
                  'https://via.placeholder.com/80', // Remplacer par vos assets
            ),
            SizedBox(height: 12),
            CartItemCard(
              title: 'Gel Coiffant Tenue Forte',
              price: '4 500 CFA',
              quantity: 1,
              stock: 54,
              imageUrl: 'https://via.placeholder.com/80',
            ),
            SizedBox(height: 12),
            CartItemCard(
              title: 'Sérum Anti-Frisottis',
              price: '5 500 CFA',
              quantity: 3,
              stock: 88,
              imageUrl: 'https://via.placeholder.com/80',
            ),
            SizedBox(height: 24),

            // --- Section Code Promo ---
            PromoCodeSection(),
            SizedBox(height: 24),

            // --- Section Résumé de la commande ---
            OrderSummarySection(),
            SizedBox(height: 24),

            // --- Boutons d'action ---
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CheckoutScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPink,
                  foregroundColor: kWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                icon: Icon(Icons.lock_outline, size: 20),
                label: Text(
                  'Passer la commande',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: kTextLight.withValues(alpha: 0.08),
                  foregroundColor: kText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Continuer mes achats',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// --- Composant : Carte Article ---
class CartItemCard extends StatelessWidget {
  final String title;
  final String price;
  final int quantity;
  final int stock;
  final String imageUrl;

  CartItemCard({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
    required this.stock,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kTextLight.withValues(alpha: 0.1)),
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image de l'article
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: kBg,
              width: 80,
              height: 80,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 12),
          // Détails
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: kText,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    color: kPink,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                // Sélecteur Quantité
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: kBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.remove,
                              size: 16,
                              color: kTextLight,
                            ),
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              color: kText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add, size: 16, color: kTextLight),
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Stock: $stock disponibles',
                  style: TextStyle(color: kTextLight, fontSize: 11),
                ),
              ],
            ),
          ),
          // Bouton Supprimer
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

// --- Composant : Section Code Promo ---
class PromoCodeSection extends StatelessWidget {
  PromoCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kTextLight.withValues(alpha: 0.1)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Code promo',
            style: TextStyle(
              color: kText,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Entrez votre code',
                      hintStyle: TextStyle(color: kTextLight, fontSize: 14),
                      filled: true,
                      fillColor: kBg,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPinkLight,
                    foregroundColor: kPink,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Appliquer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          // Info InfoBox Codes Dispo
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.blue[700]),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Codes disponibles: BEAUTY10 (-10%), FIRST20 (-20%)',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 12,
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
}

// --- Composant : Section Résumé de la commande ---
class OrderSummarySection extends StatelessWidget {
  OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kTextLight.withValues(alpha: 0.1)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Résumé de la commande',
            style: TextStyle(
              color: kText,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sous-total', style: TextStyle(color: kTextLight)),
              Text(
                '38 000 CFA',
                style: TextStyle(color: kText, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Frais de livraison', style: TextStyle(color: kTextLight)),
              Text(
                '2 000 CFA',
                style: TextStyle(color: kText, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  color: kText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '40 000 CFA',
                style: TextStyle(
                  color: kPink,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
