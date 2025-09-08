import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/themes/themes.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/buttons/submit_button.dart';
import 'login_page.dart';

class DocumentPage extends StatefulWidget {
  int? commune;
  String? nom;
  String? prenom;
  String? phone;
  String? naissance;
  String? password;
  String? photo;

  DocumentPage({
    super.key,
    this.commune,
    this.nom,
    this.prenom,
    this.phone,
    this.naissance,
    this.password,
    this.photo,
  });

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final _formKey = GlobalKey<FormState>();

  File? _rectoImage;
  File? _versoImage;

  Future<void> _pickImage({required bool isRecto}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        if (isRecto) {
          _rectoImage = File(pickedFile.path);
        } else {
          _versoImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [appColor.withValues(alpha: 0.3), appColorWhite],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      FloatingActionButton.small(
                        backgroundColor: appColorWhite,
                        elevation: 3,
                        heroTag: 'BackCity',
                        onPressed: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: appColor,
                          size: 18,
                        ),
                      ),
                      Gap(2.w),
                      Text(
                        AppConstants.appName,
                        style: TextStyle(
                          color: appColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black26,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(3.h),
                  Text(
                    "Pièces d'identité",
                    style: TextStyle(
                      color: appColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    "Veuillez prendre une photo recto verso de votre pièce d'identité",
                    style: TextStyle(
                      color: appColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                  Gap(3.h),

                  /// Recto
                  _buildCardUpload(
                    label: "Recto",
                    imageFile: _rectoImage,
                    onPick: () => _pickImage(isRecto: true),
                  ),

                  Gap(3.h),

                  /// Verso
                  _buildCardUpload(
                    label: "Verso",
                    imageFile: _versoImage,
                    onPick: () => _pickImage(isRecto: false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(4.w),
        child: SubmitButton(
          AppConstants.btnRegister,
          onPressed: () async {
            if (_rectoImage != null && _versoImage != null) {
              inscrireUtilisateur();
            } else {
              SnackbarHelper.showError(
                context,
                "Vos pièces d'identité sont obligatoires",
              );
            }
          },
        ),
      ),
    );
  }
  Widget _buildCardUpload({
    required String label,
    required File? imageFile,
    required VoidCallback onPick,
  }) {
    return GestureDetector(
      onTap: onPick,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            margin: EdgeInsets.only(bottom: 1.h),
            decoration: BoxDecoration(
              color: appColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(3.w),
              image: imageFile != null
                  ? DecorationImage(
                image: FileImage(imageFile),
                fit: BoxFit.cover,
              )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: imageFile == null
                ? Center(
              child: Text(
                label,
                style: TextStyle(
                  color: appColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : null,
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: CircleAvatar(
              backgroundColor: appColor,
              radius: 20,
              child: Icon(
                Icons.photo_camera_outlined,
                size: 20,
                color: appColorWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> inscrireUtilisateur() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              const Expanded(child: Text('Inscription encours...')),
            ],
          ),
        );
      },
    );

    var uri = Uri.parse(ApiUrls.postRegister);

    var request = http.MultipartRequest('POST', uri)
      ..fields['nom'] = widget.nom!
      ..fields['prenom'] = widget.prenom!
      ..fields['phone'] = widget.phone!
      ..fields['naissance'] = widget.naissance!
      ..fields['password'] = widget.password!
      ..fields['commune'] = widget.commune!.toString()
      ..files.add(await http.MultipartFile.fromPath('photo', widget.photo!))
      ..files.add(await http.MultipartFile.fromPath('recto', _rectoImage!.path))
      ..files.add(
        await http.MultipartFile.fromPath('verso', _versoImage!.path),
      );

    var response = await request.send();

    final res = await http.Response.fromStream(response);
    final data = jsonDecode(utf8.decode(res.bodyBytes));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
      SnackbarHelper.showSuccess(context, data['message']);
    } else {
      Navigator.pop(context);
      SnackbarHelper.showError(context, data['message']);
    }
  }
}
