import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../themes/themes.dart';

class SubmitButtonIcon extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? couleur;
  final Color? textcouleur;
  final Color? colorIcon;
  final Icon? icone;
  final double? heightSvg;
  final double? widthSvg;

  const SubmitButtonIcon(
    this.title, {
    super.key,
    required this.onPressed,
    this.height,
    this.fontSize,
    this.couleur,
    this.width,
    this.textcouleur,
    this.colorIcon,
    this.heightSvg,
    this.widthSvg,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 12.w,
      child: ElevatedButton.icon(
        icon: icone!,
        style: ElevatedButton.styleFrom(
          backgroundColor: couleur ?? appColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
          ),
        ),
        onPressed: onPressed,
        label: Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 18.sp,
            color: textcouleur ?? appColorWhite,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
