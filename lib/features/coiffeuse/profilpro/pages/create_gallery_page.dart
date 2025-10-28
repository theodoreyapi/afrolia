import 'dart:convert';
import 'dart:io';

import 'package:afrolia/core/constants/constants.dart';
import 'package:afrolia/core/themes/themes.dart';
import 'package:afrolia/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/app_constant.dart';
import '../../../../core/widgets/buttons/submit_button.dart';

class CreateGalleryPage extends StatefulWidget {
  const CreateGalleryPage({super.key});

  @override
  State<CreateGalleryPage> createState() => _CreateGalleryPageState();
}

class _CreateGalleryPageState extends State<CreateGalleryPage> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];

  // Ouvrir la caméra
  Future<void> _pickFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  // Ouvrir la galerie (plusieurs images possibles)
  Future<void> _pickFromGallery() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  // Supprimer une image
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorFond,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                    Text(
                      "Ma galerie photo",
                      style: TextStyle(
                        color: appColorText,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Gap(4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: _pickFromCamera,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: appColorBorder,
                              borderRadius: BorderRadius.circular(3.w),
                            ),
                            child: Icon(Icons.camera_alt, color: appColorText, size: 50),
                          ),
                          Text(
                            "Photo",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.sp,
                              color: appColorBlack,
                            ),
                          ),
                          Gap(1.h),
                        ],
                      ),
                    ),
                    Text(
                      "ou",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18.sp,
                        color: appColorBlack,
                      ),
                    ),
                    InkWell(
                      onTap: _pickFromGallery,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: appColorBorder,
                              borderRadius: BorderRadius.circular(3.w),
                            ),
                            child: Icon(Icons.image, color: appColorText, size: 50),
                          ),
                          Text(
                            "Galerie",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.sp,
                              color: appColorBlack,
                            ),
                          ),
                          Gap(1.h),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(2.h),
                /// Affichage des images choisies
                Center(
                  child: Wrap(
                    spacing: 18,
                    runSpacing: 18,
                    children: List.generate(_images.length, (index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _images[index],
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _removeImage(index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(
                                    alpha: 0.88,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(7.w),
        child: SubmitButton(AppConstants.btnAddGal, onPressed: () async {
          addGallery(context);
        }),
      ),
    );
  }

  Future<void> addGallery(BuildContext context) async {
    if (_images.isEmpty) {
      SnackbarHelper.showError(context, "Veuillez ajouter au moins une image.");
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Expanded(child: Text('Envoi en cours...')),
            ],
          ),
        );
      },
    );

    try {
      HttpClient().badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      final uri = Uri.parse(ApiUrls.postSaveGallery);
      final request = http.MultipartRequest('POST', uri);

      // 🧩 ID de l’utilisateur connecté (à remplacer par ton ID réel)
      request.fields['id_utilisateur'] = SharedPreferencesHelper().getString('identifiant').toString();

      // 🖼️ Ajouter chaque image dans le tableau "images[index][image]"
      for (int i = 0; i < _images.length; i++) {
        final imageFile = _images[i];
        final multipartFile = await http.MultipartFile.fromPath(
          'images[$i][image]', // correspond à "images.*.image" attendu par Laravel
          imageFile.path,
        );
        request.files.add(multipartFile);

        // Si tu veux ajouter une description (facultatif)
        request.fields['images[$i][description]'] = "";
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      Navigator.pop(context);

      debugPrint("Status: ${response.statusCode}");
      debugPrint("Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
        jsonDecode(utf8.decode(response.bodyBytes));

        if (responseData['success'] == true) {
          SnackbarHelper.showSuccess(context, "Images ajoutées avec succès !");
          setState(() {
            _images.clear();
          });
        } else {
          SnackbarHelper.showError(
              context, responseData['message'] ?? "Erreur inconnue.");
        }
      } else {
        SnackbarHelper.showError(
            context, "Erreur ${response.statusCode} lors de l’envoi.");
      }
    } catch (e) {
      Navigator.pop(context);
      SnackbarHelper.showError(context, "Erreur de connexion : $e");
    }
  }

}
