import 'dart:convert';
import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:afrolia/core/widgets/widgets.dart';
import 'package:afrolia/features/coiffeuse/profilpro/profilepro.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<Map<String, dynamic>> images = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGallery();
  }

  // ⚡ Récupération des images depuis l'API
  Future<void> fetchGallery() async {
    setState(() => isLoading = true);

    try {
      final uri = Uri.parse(
        "${ApiUrls.getListGallery}${SharedPreferencesHelper().getString('identifiant')}",
      ); // adapter userId
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          setState(() {
            images = List<Map<String, dynamic>>.from(data['data']);
          });
        } else {
          SnackbarHelper.showError(
            context,
            data['message'] ?? "Erreur inconnue",
          );
        }
      } else {
        SnackbarHelper.showError(
          context,
          "Erreur ${response.statusCode} lors de la récupération",
        );
      }
    } catch (e) {
      SnackbarHelper.showError(context, "Erreur de connexion : $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  // ❌ Supprimer une image
  Future<void> deleteImage(int id, int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmer la suppression"),
        content: const Text("Voulez-vous vraiment supprimer cette image ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final uri = Uri.parse("${ApiUrls.deleteDeleteGallery}$id");
      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          setState(() => images.removeAt(index));
          SnackbarHelper.showSuccess(context, "Image supprimée avec succès !");
        } else {
          SnackbarHelper.showError(
            context,
            data['message'] ?? "Erreur inconnue",
          );
        }
      } else {
        SnackbarHelper.showError(
          context,
          "Erreur ${response.statusCode} lors de la suppression",
        );
      }
    } catch (e) {
      SnackbarHelper.showError(context, "Erreur de connexion : $e");
    }
  }

  void _refreshData() {
    setState(() {
      fetchGallery();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FloatingActionButton.small(
                    backgroundColor: appColorWhite,
                    elevation: 0,
                    shape: CircleBorder(),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back, color: appColorText),
                  ),
                  Spacer(),
                  Text(
                    "Ma galerie photo",
                    style: TextStyle(
                      color: appColorText,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton.small(
                    shape: CircleBorder(),
                    elevation: 0,
                    heroTag: 'Refesh',
                    tooltip: 'Actualiser la liste',
                    backgroundColor: appColorWhite,
                    onPressed: _refreshData,
                    child: Icon(Icons.refresh, color: appColorText),
                  ),
                ],
              ),
              Gap(2.h),
              isLoading
                  ? Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: appColor),
                      ),
                    )
                  : images.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          "Aucune image disponible.\nAjoutez-en pour remplir votre galerie !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: appColorTextSecond,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        itemCount: images.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3.w,
                          mainAxisSpacing: 3.w,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final image = images[index];
                          return Stack(
                            children: [
                              // 🌟 Image avec coins arrondis et légère ombre
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3.w),
                                child: Image.network(
                                  image['image'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: appColor,
                                          ),
                                        );
                                      },
                                  errorBuilder: (_, __, ___) => Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              // ❌ Bouton suppression
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () =>
                                      deleteImage(image['id_gallery'], index),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.88,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(7.w),
        child: SubmitButton(
          AppConstants.btnAddGallery,
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateGalleryPage(),
              ),
            );
            if (result != null) {
              fetchGallery(); // rafraîchit la galerie après ajout
            }
          },
        ),
      ),
    );
  }
}
