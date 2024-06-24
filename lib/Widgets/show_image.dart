import 'dart:io';

import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowImage extends StatelessWidget {
  final VoidCallback? onDelete;
  final String? imageUrl;

  const ShowImage({this.imageUrl, this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: Get.height * .2,
          width: Get.width * .4,
          decoration: BoxDecoration(
              image: imageUrl != null
                  ? DecorationImage(image: FileImage(File(imageUrl!)), fit: BoxFit.fill)
                  : null,
              color: Colors.white,
              border: Border.all(color: AppTheme.secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.delete,
                color: AppTheme.primaryColor,
              ),
            )),
      ],
    );
  }
}
