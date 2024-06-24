import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Widget? prefix;
  final Widget? suffix;
  final Color? buttonColor;
  final double borderRadius;

  const AppButton(
    this.title, {
    this.buttonColor,
    this.onTap,
    this.prefix,
    this.suffix,
    this.borderRadius = 5.0,
    super.key,
  });

  @override
  // Widget build(BuildContext context) {
  //   return ElevatedButton(
  //       onPressed: onTap,
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.resolveWith((states) {
  //           return onTap != null
  //               ? (buttonColor ?? AppTheme.primaryColor)
  //               : AppTheme.primaryColor.withOpacity(.5);
  //         }),
  //
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 15),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             if (prefix != null) prefix!,
  //             Text(
  //               title,
  //               style: const TextStyle(color: Colors.white),
  //             ),
  //             if (suffix != null) suffix!,
  //           ],
  //         ),
  //       ));
  // }
// }

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return onTap != null
              ? (buttonColor ?? AppTheme.primaryColor)
              : AppTheme.primaryColor.withOpacity(.5);
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefix != null) prefix!,
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }
}

class AppButtonWithCorners extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Widget? prefix;
  final Widget? suffix;
  final Color? buttonColor;
  final double radius;
  final double? height;
  final double? width;

  const AppButtonWithCorners(
    this.title, {
    this.buttonColor,
    this.onTap,
    this.prefix,
    this.suffix,
    super.key,
    this.radius = 10,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: height ?? 50,
          width: width ?? Get.width,
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(radius)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefix != null) prefix!,
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                if (suffix != null) suffix!,
              ],
            ),
          )),
    );
  }
}
