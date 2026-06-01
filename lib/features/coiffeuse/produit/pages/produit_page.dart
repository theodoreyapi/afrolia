import 'package:flutter/material.dart';

const kOrangeMain = Color(0xFFE66400); // Couleur du bouton principal vendeur
const kOrangeLight = Color(0xFFFFF4EB);
const kGold = Color(0xFFFFB300);
const kGoldLight = Color(0xFFFEF9E7);
const kPink = Color(0xFFE91E8C);
const kText = Color(0xFF1A1A2E);
const kTextLight = Color(0xFF8E8E9E);
const kBg = Color(0xFFFDFBF7); // Fond chaud présent sur la version vendeur
const kWhite = Colors.white;
const kGreenActive = Color(0xFF4CAF50);
const kGreenBg = Color(0xEAF2F4EA);

class ProduitPage extends StatefulWidget {
  ProduitPage({super.key});

  @override
  State<ProduitPage> createState() => _ProduitPageState();
}

class _ProduitPageState extends State<ProduitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.5,
        title: Text(
          'Tableau de bord',
          style: TextStyle(
            color: kText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: kText),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- GRILLE DES STATISTIQUES (KPIs) ---
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                StatCard(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: Colors.purple,
                  badgeText: '4 actifs',
                  badgeColor: Color(0xFFF3E5F5),
                  value: '5',
                  title: 'Produits',
                ),
                StatCard(
                  icon: Icons.euro,
                  // Remplacer par l'icône monnaie adéquate si besoin
                  iconColor: kGreenActive,
                  badgeText: '+12%',
                  badgeColor: kGreenBg,
                  value: '1245k',
                  title: 'Revenus produits',
                ),
                StatCard(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.blue,
                  badgeText: '1',
                  badgeColor: Color(0xFFE3F2FD),
                  value: '1',
                  title: 'Commandes en attente',
                ),
                StatCard(
                  icon: Icons.local_shipping_outlined,
                  iconColor: kOrangeMain,
                  badgeText: '1',
                  badgeColor: kOrangeLight,
                  value: '258',
                  title: 'Produits vendus',
                ),
              ],
            ),
            SizedBox(height: 24),

            // --- BOUTON AJOUTER UN PRODUIT ---
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => _showAddProductBottomSheet(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kOrangeMain,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                icon: Icon(Icons.add, color: kWhite, size: 24),
                label: Text(
                  'Ajouter un produit',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 28),

            // --- TITRE DE SECTION ---
            Text(
              'Mes produits',
              style: TextStyle(
                color: kText,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 14),

            // --- LISTE DES PRODUITS VENDEURS ---
            VendorProductCard(
              title: 'Huile de Coco Bio',
              category: 'Soins',
              price: '8 500',
              stock: 24,
              sales: 45,
              isActive: true,
            ),
            SizedBox(height: 12),
            VendorProductCard(
              title: 'Beurre de Karité Pur',
              category: 'Soins',
              price: '6 500',
              stock: 18,
              sales: 67,
              isActive: true,
            ),
            SizedBox(height: 12),
            VendorProductCard(
              title: 'Gel Coiffant Naturel',
              category: 'Coiffage',
              price: '5 500',
              stock: 0,
              sales: 89,
              isActive: false,
            ),
            SizedBox(height: 12),
            VendorProductCard(
              title: 'Spray Démêlant',
              category: 'Soins',
              price: '7 200',
              stock: 32,
              sales: 34,
              isActive: true,
            ),
          ],
        ),
      ),
    );
  }

  // --- MODAL DE Saisie : AJOUTER UN PRODUIT ---
  void _showAddProductBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            top: 24,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ajouter un produit',
                      style: TextStyle(
                        color: kText,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: kTextLight),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildFormLabel('Nom du produit *'),
                _buildTextField('Ex: Huile de Coco Bio'),
                SizedBox(height: 16),
                _buildFormLabel('Catégorie *'),
                _buildDropdownField(['Soins', 'Coiffage', 'Accessoires']),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFormLabel('Prix (CFA) *'),
                          _buildTextField('0', isNumber: true),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFormLabel('Stock *'),
                          _buildTextField('0', isNumber: true),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _buildFormLabel('Description *'),
                _buildTextField(
                  'Décrivez votre produit, ses bienfaits...',
                  maxLines: 3,
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Maximum 500 caractères  0/500',
                    style: TextStyle(color: kTextLight, fontSize: 11),
                  ),
                ),
                SizedBox(height: 16),

                // Note d'information sur la commission
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kGoldLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kGold.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, color: kGold, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Commission plateforme',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kText,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Une commission de 10% est appliquée sur chaque vente de produit.',
                              style: TextStyle(color: kText, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOrangeMain,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Enregistrer le produit',
                      style: TextStyle(
                        color: kWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: kText,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return TextField(
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: kTextLight, fontSize: 14),
        fillColor: kWhite,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kGold.withValues(alpha: 0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kOrangeMain),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildDropdownField(List<String> items) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kGold.withValues(alpha: 0.4)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.first,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: kOrangeMain),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: kText, fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ),
    );
  }
}

// --- COMPOSANT : CARTE DE STATISTIQUE (KPI) ---
class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String badgeText;
  final Color badgeColor;
  final String value;
  final String title;

  StatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.badgeText,
    required this.badgeColor,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    color: iconColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: kText,
                ),
              ),
              Text(
                title,
                style: TextStyle(color: kTextLight, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- COMPOSANT : LIGNE PRODUIT VENDEUR ---
class VendorProductCard extends StatelessWidget {
  final String title;
  final String category;
  final String price;
  final int stock;
  final int sales;
  final bool isActive;

  VendorProductCard({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.stock,
    required this.sales,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kTextLight.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kBg,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: kText,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? kGreenBg
                                : kTextLight.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isActive ? 'Actif' : 'Inactif',
                            style: TextStyle(
                              color: isActive ? kGreenActive : kTextLight,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      category,
                      style: TextStyle(color: kTextLight, fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          'Prix ',
                          style: TextStyle(color: kTextLight, fontSize: 12),
                        ),
                        Text(
                          '$price ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kOrangeMain,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 14),
                        Text(
                          'Stock ',
                          style: TextStyle(color: kTextLight, fontSize: 12),
                        ),
                        Text(
                          '$stock ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: stock == 0 ? Colors.red : kText,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 14),
                        Text(
                          'Vendus ',
                          style: TextStyle(color: kTextLight, fontSize: 12),
                        ),
                        Text(
                          '$sales',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kGreenActive,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionButton(Icons.edit_outlined, 'Modifier', kOrangeMain),
              _buildActionButton(
                isActive
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                isActive ? 'Désactiver' : 'Activer',
                Colors.blue,
              ),
              _buildActionButton(
                Icons.delete_outline,
                'Supprimer',
                Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: label == 'Supprimer' ? Colors.redAccent : kText,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
