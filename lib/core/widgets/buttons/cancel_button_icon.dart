import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../themes/themes.dart';


class CancelButtonIcon extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? colorIcon;
  final Icon? icone;
  final double? heightSvg;
  final double? widthSvg;

  const CancelButtonIcon(
      this.title, {super.key,
        required this.onPressed,
        this.height,
        this.width,
        this.fontSize,
        this.colorIcon,
        this.heightSvg,
        this.widthSvg,
        this.icone,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 12.w,
      child: ElevatedButton.icon(
        icon: icone!,
        style: ElevatedButton.styleFrom(
          backgroundColor: appColorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
            side: BorderSide(color: appColorBorder),
          ),
        ),
        onPressed: onPressed,
        label: Text(
          title,
          style: TextStyle(
            fontSize: fontSize ?? 18.sp,
            color: appColorText,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}