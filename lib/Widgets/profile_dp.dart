import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:darasni/Widgets/full_screen_image.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProfileDP extends StatelessWidget {
  final String? fileImage;
  final String? imageUrl;
  final double? radius;
  final VoidCallback? onDelete;

  const ProfileDP({this.imageUrl, this.fileImage, this.onDelete, this.radius, super.key});

  @override
  Widget build(BuildContext context) {
    return fileImage != null
        ? Stack(
            children: [
              CircleAvatar(
                radius: radius ?? 25,
                backgroundImage: FileImage(File(fileImage ?? "")),
                backgroundColor: AppTheme.appGreyColor,
              ),
              if (fileImage != null)
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Icon(
                      Icons.cancel_outlined,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
            ],
          )
        : CachedNetworkImage(
            imageUrl: imageUrl ?? "",
            imageBuilder: (context, imageProvider) => GestureDetector(
              onTap: () {
                if (imageUrl == null) return;
                Get.to(() => FullScreenImageView(image: imageUrl));
              },
              child: CircleAvatar(
                radius: radius ?? 25,
                backgroundImage: imageProvider,
                backgroundColor: Colors.transparent,
              ),
            ),
            placeholder: (context, url) => ImageLoader(
              radius: radius,
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              backgroundColor: AppTheme.appGreyColor,
              radius: 50,
              child: Icon(Icons.person, color: AppTheme.greyColor),
            ),
          );
  }
}

class ImageLoader extends StatelessWidget {
  final double? radius;

  const ImageLoader({this.radius, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: CircleAvatar(
          radius: radius ?? 25,
        ));
  }
}
