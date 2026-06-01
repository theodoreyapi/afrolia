import 'package:flutter/material.dart';

// --- Palette de couleurs ---
const kPink = Color(0xFFE91E8C);
const kPinkLight = Color(0xFFFCE4F0);
const kText = Color(0xFF1A1A2E);
const kTextLight = Color(0xFF8E8E9E);
const kBg = Color(0xFFFAFAFA);
const kWhite = Colors.white;

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = 'orange';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kBg,
        elevation: 0,
        leading: BackButton(color: kText),
        title: Text(
          'Finaliser la commande',
          style: TextStyle(color: kText, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // --- SECTION : ADRESSE ---
                  _buildSectionCard(
                    icon: Icons.location_on_outlined,
                    title: 'Adresse de livraison',
                    child: Column(
                      children: [
                        _buildInputField(label: 'Nom complet *', hint: 'Votre nom complet'),
                        SizedBox(height: 16),
                        _buildInputField(label: 'Téléphone *', hint: '+225 XX XX XX XX XX'),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: _buildInputField(label: 'Ville *', hint: 'Abidjan')),
                            SizedBox(width: 12),
                            Expanded(child: _buildInputField(label: 'Quartier *', hint: 'Ex: Cocody')),
                          ],
                        ),
                        SizedBox(height: 16),
                        _buildInputField(label: 'Adresse complète *', hint: 'Numéro de rue, bâtiment, point de repère...'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // --- SECTION : PAIEMENT ---
                  _buildSectionCard(
                    icon: Icons.payment_outlined,
                    title: 'Méthode de paiement',
                    child: Column(
                      children: [
                        _buildPaymentTile('orange', 'Orange Money', 'Paiement mobile sécurisé', 'assets/orange.png'),
                        _buildPaymentTile('mtn', 'MTN Money', 'Paiement mobile sécurisé', 'assets/mtn.png'),
                        _buildPaymentTile('cash', 'Paiement à la livraison', 'Payez en espèces', null, iconData: Icons.money_outlined),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // --- SECTION : RECAPITULATIF ---
                  _buildSectionCard(
                    icon: Icons.list_alt_outlined,
                    title: 'Récapitulatif de commande',
                    child: Column(
                      children: [
                        _buildRecapItem('Huile de Coco Vierge Bio', '2', '17 000 CFA'),
                        _buildRecapItem('Gel Coiffant Tenue Forte', '1', '4 500 CFA'),
                        _buildRecapItem('Sérum Anti-Frisottis', '3', '16 500 CFA'),
                        Divider(height: 32),
                        _buildSummaryRow('Sous-total', '38 000 CFA'),
                        SizedBox(height: 8),
                        _buildSummaryRow('Frais de livraison', '2 000 CFA'),
                        SizedBox(height: 12),
                        _buildSummaryRow('Total', '40 000 CFA', isTotal: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- BARRE DE VALIDATION BASSE ---
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: Offset(0, -5))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPink,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text('Confirmer la commande', style: TextStyle(color: kWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'En passant commande, vous acceptez nos conditions générales de vente',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kTextLight, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helpers UI ---
  Widget _buildSectionCard({required IconData icon, required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kTextLight.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: kPink, size: 20),
              SizedBox(width: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: kText, fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildInputField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: kTextLight, fontSize: 13)),
        SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: kTextLight, fontSize: 14),
            fillColor: kBg,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentTile(String id, String name, String sub, String? asset, {IconData? iconData}) {
    bool isSelected = selectedPayment == id;
    return GestureDetector(
      onTap: () => setState(() => selectedPayment = id),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? kPink : kTextLight.withValues(alpha: 0.1)),
          color: isSelected ? kPinkLight.withValues(alpha: 0.3) : kWhite,
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: kBg, borderRadius: BorderRadius.circular(8)),
              child: asset != null ? Image.asset(asset) : Icon(iconData, color: Colors.green),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(sub, style: TextStyle(color: kTextLight, fontSize: 12)),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle, color: kPink, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRecapItem(String name, String qty, String price) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 40, height: 40, color: kBg), // Placeholder image
          SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Text('Quantité: $qty', style: TextStyle(fontSize: 11, color: kTextLight)),
            ]),
          ),
          Text(price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: isTotal ? kText : kTextLight, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(color: isTotal ? kPink : kText, fontWeight: FontWeight.bold, fontSize: isTotal ? 18 : 14)),
      ],
    );
  }
}